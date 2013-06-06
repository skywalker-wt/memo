@ECHO OFF
SETLOCAL

SET cert=datatransfer-peertrust.pfx
SET winhttpcertcfg=winhttpcertcfg.exe
SET certificateManager=importpfx.exe
SET certutil=certutil.exe
SET testCertPassword=
for /f "delims=" %%A in (pfxPassword.txt) do SET testCertPassword=%%A
IF "%testCertPassword%"=="" ( echo. Failed to obtain test pfx certificate password & goto :DONE)

:LOCAL_MACHINE/CURRENT_USER
IF EXIST "%cert%" (
	"%winhttpcertcfg%" -g -i "%cert%" -c "CURRENT_USER\MY" -p "%testCertPassword%" -a "Network Service"
    "%certificateManager%" -f "%cert%" -p  "%testCertPassword%" -t MACHINE -s TrustedPeople       
    echo Successfully installed certificate.
    echo.
) ELSE (
    echo. Client certificate "%cert%" is not accessible
)