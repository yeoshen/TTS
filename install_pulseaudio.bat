@ECHO OFF

SET "LINUXTMP=$(echo '%TMP:\=\\%' | sed -e 's|\\|/|g' -e 's|^\([A-Za-z]\)\:/\(.*\)|/mnt/\L\1\E/\2|')"
echo LINUXTMP = "%LINUXTMP%"
 
ECHO --- PulseAudio...
C:\Windows\System32\bash.exe -xc "wget -cO '%LINUXTMP%/pulseaudio.zip' 'http://bosmans.ch/pulseaudio/pulseaudio-1.1.zip'"
 
ECHO --- Extracting PulseAudio
md "%TMP%\pulseaudio"
C:\Windows\System32\bash.exe -xc "unzip -o '%LINUXTMP%/pulseaudio.zip' -d '%LINUXTMP%/pulseaudio'"
 
ECHO --- Installing PulseAudio
xcopy /e "%TMP%\pulseaudio" "%AppData%\PulseAudio\"
 
ECHO --- Setting PulseAudio to run at startup
echo set ws=wscript.createobject("wscript.shell") > "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_pulseaudio.vbe"
echo ws.run "%AppData%\PulseAudio\bin\pulseaudio.exe --exit-idle-time=-1",0 >> "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_pulseaudio.vbe"
 
REM Recomended/required settings
echo load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 >> "%AppData%\PulseAudio\etc\pulse\default.pa"
"%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_pulseaudio.vbe"
ECHO When prompted, DO NOT allow 'pulseaudio' access to any of your networks.  It doesn't need access.
 
ECHO All Done
PAUSE
