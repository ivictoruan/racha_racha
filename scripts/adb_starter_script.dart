import 'dart:convert';
import 'dart:developer';
import 'dart:io';

void main() {
  // INICIA PORTA TCPIP 5556
  executeCommand('adb tcpip 5556'); 
  // CONECTA IP NA PORTA (CELULAR VIA WIFI) 
  executeCommand('adb connect 192.168.1.4:5556');
}

void executeCommand(String command) {
  Process.start('cmd', ['/c', command]).then((Process process) {
    process.stdout.transform(utf8.decoder).listen((data) {
      log(data);
    });

    process.stderr.transform(utf8.decoder).listen((data) {
      log(data);
    });

    process.exitCode.then((exitCode) {
      log('Command executed with exit code $exitCode');
    });
  });
}
