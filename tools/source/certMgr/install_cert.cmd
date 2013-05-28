@ECHO OFF
SETLOCAL

SET cert=127.0.0.3_for_test.pfx
SET winhttpcertcfg=winhttpcertcfg.exe
SET certificateManager=importpfx.exe
SET certutil=certutil.exe
SET testCertPassword=
for /f "delims=" %%A in (pfxPassword.txt) do SET testCertPassword=%%A
IF "%testCertPassword%"=="" ( echo. Failed to obtain test pfx certificate password & goto :DONE)

IF EXIST "%cert%" (
	"%certutil%" -f -p "%testCertPassword%" -importpfx "%cert%"
    "%certificateManager%" -f "%cert%" -p  "%testCertPassword%" -t MACHINE -s TrustedPeople       
    echo Successfully installed certificate.
    echo.
) ELSE (
    echo. Client certificate "%cert%" is not accessible
)