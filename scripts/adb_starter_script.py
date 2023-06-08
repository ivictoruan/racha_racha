import os

# Executa o comando "adb tcpip 5554"
os.system('adb tcpip 5556')

# Executa o comando "adb connect 192.168.1.4:5554"
os.system('adb connect 192.168.1.3:5556')

# os.system('adb connect 10.57.81.61:5556') 
