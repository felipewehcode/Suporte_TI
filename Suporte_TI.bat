@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion
:: ==================================================
:: PAINEL DE SUPORTE TECNICO - COMPLETO
:: Criado por Felipe Wehmuth - 2025
:: ==================================================
title Painel de Suporte Tecnico
mode con: cols=95 lines=60

:: =====================================
:: CONFIGURACOES GERAIS (edite aqui)
:: =====================================
set "VERSAO=1.2.0"
set "URL_CHAMADO=https://suporte.exemplo.com"
set "GITHUB_REPO=https://github.com/felipewehcode/painel_de_suporte/archive/refs/heads/main.zip"
set "LOG_FILE=%~dp0painel_log.txt"

:: =====================================
:: VERIFICACAO DE ADMINISTRADOR
:: =====================================
net session >nul 2>&1
if errorlevel 1 (
    echo Este script precisa ser executado como ADMINISTRADOR!
    echo Clique com o botao direito no arquivo e escolha "Executar como administrador".
    pause
    exit /b
)

:: =====================================
:: PROTECAO POR SENHA
:: Obs: isto e apenas uma trava simples de acesso local,
:: NAO e criptografado e nao deve ser usado como seguranca real.
:: =====================================
set "SENHA_CORRETA=FW2026"

:LOGIN
cls
echo =======================================
echo        PAINEL DE SUPORTE TECNICO
echo =======================================
:: Senha digitada nao aparece na tela (via PowerShell -AsSecureString)
for /f "usebackq delims=" %%p in (`powershell -NoProfile -Command "$s = Read-Host 'Digite a senha de acesso' -AsSecureString; $b = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($s); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($b)"`) do set "SENHA=%%p"
if "%SENHA%"=="%SENHA_CORRETA%" (
    echo Acesso permitido...
    timeout /t 1 >nul
    goto COR
) else (
    echo Senha incorreta! Tente novamente.
    timeout /t 2 >nul
    goto LOGIN
)

:: =====================================
:: ROTINA DE CORES
:: =====================================
:COR
cls
echo ================================================================
echo               SELECIONE A COR DO PAINEL
echo ------------------------------------------------
echo 0 = Preto       8 = Cinza
echo 1 = Azul        9 = Azul claro
echo 2 = Verde       A = Verde claro
echo 3 = Aqua        B = Aqua claro
echo 4 = Vermelho    C = Vermelho claro
echo 5 = Roxo        D = Roxo claro
echo 6 = Amarelo     E = Amarelo claro
echo 7 = Branco      F = Branco brilhante
echo ------------------------------------------------
echo FORMATO: FundoTexto  (Exemplo: 0B = fundo preto, texto aqua claro)
echo.
set /p cor="Digite o codigo da cor (ou pressione ENTER para usar padrao): "
if "%cor%"=="" (
    color 07
) else (
    color %cor%
)
goto MENU

:: =====================================
:: MENU PRINCIPAL
:: =====================================
:MENU
cls
echo █   █ █████ █     ████      ████  █████  ████ █   █   
echo █░  █░█░░░░░█░    █░░░█     █░░░█ █░░░░░█ ░░░░█░ █ ░  
echo █████░████░░█░░   ████░░    █░░░█░████░░░███░░███ ░ ░ 
echo █░░░█░█░░░░ █░░   █░░░░ ░█  █░░ █░█░░░░   ░░█ █░░█ ░  
echo █░░░█░█████░█████ █░░░░░ █░ ████ ░█████░████░░█░░░█   
echo  ░░  ░░░░░░░ ░░░░░ ░░     ░░ ░░░░ ░░░░░░ ░░░░ ░░░  ░  
echo   ░    ░ ░░░░░ ░░░░░ ░        ░  ░░░░  ░░░░░ ░░░░  ░    ░ 
echo.
echo.
echo ===================================================================
echo                    CRIADO POR FELIPE WEHMUTH
echo                   FERRAMENTA PARA USO DO TECNICO
echo                UTILIZE A FERRAMENTA COMO ADMINISTRADOR
echo ===================================================================
echo Versao %VERSAO% - 2025
echo.
echo [1]  Limpeza de arquivos temporarios
echo [2]  Executar limpeza de disco (cleanmgr)
echo [3]  Verificacao de arquivos do sistema (SFC)
echo [4]  Reparo da imagem do Windows (DISM)
echo [5]  Reset do Windows Update
echo [6]  Reset de configuracoes de rede
echo [7]  Atualizacao das politicas de grupo (GPO)
echo [8]  Limpeza de logs de eventos
echo [9]  Informacoes do sistema (msinfo32)
echo [10] Gerenciador de dispositivos
echo [11] Ver adaptadores de rede
echo [12] Ver e atualizar programas instalados via winget
echo [13] Ver processos em execucao
echo [14] Ver status dos principais servicos
echo [15] Executar CHKDSK no disco C:
echo [16] Abrir PowerShell
echo [17] Verificar ipconfig
echo [18] Testar velocidade da internet
echo [19] Verificar espaco em disco
echo [20] Verificar status do antivirus
echo [21] Testar conectividade com o google
echo [22] Backup dos logs de eventos
echo [23] Visualizar dispositivos USB conectados
echo [24] Ver uso de memoria e CPU - Simples
echo [25] Baixar arquivo via HTTPS (exemplo com PowerShell)
echo [26] Gerar relatorio de politicas de grupo (gpresult)
echo [27] Otimizador de Memoria (Swap/RAM)
echo [U] Atualizar script
echo [99] Mudar cor
echo [0]  Sair
echo.
set /p opcao="Escolha uma opcao: "

:: =====================================
:: VALIDACAO DE ENTRADA
:: =====================================
if /I "%opcao%"=="U" goto ATUALIZAR
if "%opcao%"=="99" goto COR
if "%opcao%"=="0" exit
for /f "delims=0123456789" %%a in ("%opcao%") do (
    if /I NOT "%opcao%"=="U" (
        echo Opcao invalida! Digite um numero valido.
        pause
        goto MENU
    )
)

if %opcao% lss 1 if not "%opcao%"=="0" goto INVALIDA
if %opcao% gtr 27 if not "%opcao%"=="99" goto INVALIDA

goto EXP_%opcao%

:INVALIDA
echo Opcao invalida! Digite um numero valido.
pause
goto MENU

:: =====================================
:: FUNCOES AUXILIARES
:: =====================================

:: Exibe o cabecalho padrao de uma opcao e pergunta se deseja executar.
:: Uso: call :INFO "[N] Titulo" "Descricao" "Tempo estimado" "Afeta arquivos pessoais? Sim/Nao"
:: Retorna o valor digitado na variavel "escolha"
:INFO
cls
echo %~1
echo ------------------------------------------------
echo O que faz: %~2
echo Tempo estimado: %~3
echo Afeta meus arquivos pessoais? %~4
echo.
set /p "escolha=Deseja executar? (1=Sim / 0=Voltar): "
goto :eof

:: Registra um comando executado no arquivo de log.
:: Uso: call :LOG "descricao do comando"
:LOG
echo [%date% %time%] %~1>>"%LOG_FILE%"
goto :eof

:: Pede uma confirmacao extra para comandos sensiveis/destrutivos.
:: Uso: call :CONFIRMAR   depois checar "if errorlevel 1 goto MENU"
:CONFIRMAR
set /p "CONF=Tem certeza que deseja continuar? (S/N): "
if /I "%CONF%"=="S" (
    exit /b 0
) else (
    echo Operacao cancelada.
    pause
    exit /b 1
)

:: =====================================
:: ROTINAS COMPLETAS EXP_1 ate EXP_26
:: =====================================

:EXP_1
call :INFO "[1] Limpeza de arquivos temporarios" "Apaga arquivos temporarios do Windows que ocupam espaco inutilmente." "1 a 2 minutos" "Nao"
if "%escolha%"=="1" (
    del /s /q %temp%\*.* 2>nul
    echo Limpeza concluida!
    pause
)
goto MENU

:EXP_2
call :INFO "[2] Limpeza de disco (cleanmgr)" "Abre a ferramenta do Windows para remover arquivos desnecessarios e liberar espaco." "2 a 5 minutos" "Nao"
if "%escolha%"=="1" (
    cleanmgr
    pause
)
goto MENU

:EXP_3
call :INFO "[3] Verificacao de arquivos do sistema (SFC)" "Verifica arquivos protegidos do Windows e tenta reparar corrupcoes automaticamente." "10 a 30 minutos" "Nao"
if "%escolha%"=="1" (
    call :LOG "sfc /scannow"
    call :CONFIRMAR
    if errorlevel 1 goto MENU
    sfc /scannow
    pause
)
goto MENU

:EXP_4
call :INFO "[4] Reparo da imagem do Windows (DISM)" "Repara corrupcoes na imagem do Windows." "10 a 20 minutos" "Nao"
if "%escolha%"=="1" (
    dism /online /cleanup-image /restorehealth
    pause
)
goto MENU

:EXP_5
call :INFO "[5] Reset do Windows Update" "Reinicia os servicos do Windows Update e limpa caches." "5 a 10 minutos" "Nao"
if "%escolha%"=="1" (
    net stop wuauserv
    net stop bits
    rd /s /q %windir%\SoftwareDistribution
    net start wuauserv
    net start bits
    echo Reset do Windows Update concluido!
)
pause
goto MENU

:EXP_6
call :INFO "[6] Reset de configuracoes de rede" "Reseta IP, Winsock e configuracoes TCP/IP." "1 a 3 minutos" "Nao"
if "%escolha%"=="1" (
    ipconfig /release
    ipconfig /renew
    call :LOG "ipconfig /flushdns"
    call :CONFIRMAR
    if errorlevel 1 goto MENU
    ipconfig /flushdns
    call :LOG "netsh winsock reset"
    call :CONFIRMAR
    if errorlevel 1 goto MENU
    netsh winsock reset
    netsh int ip reset
    echo Configuracoes de rede resetadas!
)
pause
goto MENU

:EXP_7
call :INFO "[7] Atualizacao das politicas de grupo (GPO)" "Atualiza politicas de grupo locais e de dominio." "1 a 2 minutos" "Nao"
if "%escolha%"=="1" (
    gpupdate /force
    pause
)
goto MENU

:EXP_8
call :INFO "[8] Limpeza de logs de eventos" "Limpa todos os logs do Visualizador de Eventos." "1 a 2 minutos" "Nao"
if "%escolha%"=="1" (
    for /F "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G"
    echo Logs limpos!
)
pause
goto MENU

:EXP_9
call :INFO "[9] Informacoes do sistema (msinfo32)" "Abre o painel de informacoes detalhadas do sistema." "Instantaneo" "Nao"
if "%escolha%"=="1" start msinfo32
goto MENU

:EXP_10
call :INFO "[10] Gerenciador de dispositivos" "Abre o Gerenciador de Dispositivos do Windows." "Instantaneo" "Nao"
if "%escolha%"=="1" start devmgmt.msc
goto MENU

:EXP_11
call :INFO "[11] Ver adaptadores de rede" "Mostra todos os adaptadores de rede e suas configuracoes." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    ipconfig /all
    pause
)
goto MENU

:EXP_12
call :INFO "[12] Ver e atualizar programas instalados via winget" "Lista programas instalados e verifica atualizacoes com winget." "Variavel" "Nao"
if "%escolha%"=="1" (
    winget upgrade
    pause
)
goto MENU

:EXP_13
call :INFO "[13] Ver processos em execucao" "Exibe todos os processos em execucao no momento." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    tasklist
    pause
)
goto MENU

:EXP_14
call :INFO "[14] Ver status dos principais servicos" "Mostra status de servicos importantes do Windows." "Instantaneo" "Nao"
if "%escolha%"=="1" net start
pause
goto MENU

:EXP_15
call :INFO "[15] Executar CHKDSK no disco C:" "Verifica e repara erros no disco C:. ATENCAO: pode exigir reinicializacao do computador." "5 a 20 minutos" "Nao"
if "%escolha%"=="1" (
    call :CONFIRMAR
    if errorlevel 1 goto MENU
    chkdsk C: /f /r
)
pause
goto MENU

:EXP_16
call :INFO "[16] Abrir PowerShell" "Abre o Windows PowerShell." "Instantaneo" "Nao"
if "%escolha%"=="1" start powershell
goto MENU

:EXP_17
call :INFO "[17] Verificar ipconfig" "Exibe informacoes de IP e rede." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    ipconfig
    pause
)
goto MENU

:EXP_18
call :INFO "[18] Testar velocidade da internet" "Abre pagina de teste de velocidade." "Instantaneo" "Nao"
if "%escolha%"=="1" start "" "https://www.speedtest.net"
goto MENU

:EXP_19
call :INFO "[19] Verificar espaco em disco" "Mostra o espaco livre em cada unidade do sistema." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    echo Verificando espaco em disco...
    powershell -NoProfile -Command "Get-CimInstance Win32_LogicalDisk -Filter \"DriveType=3\" | Select-Object DeviceID, @{N='TamanhoGB';E={[math]::Round($_.Size/1GB,1)}}, @{N='LivreGB';E={[math]::Round($_.FreeSpace/1GB,1)}} | Format-Table -AutoSize"
    echo.
    pause
)
goto MENU

:EXP_20
call :INFO "[20] Verificar status de todos os antivirus" "Mostra todos os antivirus instalados e seu status." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    echo Verificando todos os antivirus instalados...
    powershell -NoProfile -Command "Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntivirusProduct | ForEach-Object { $_.displayName + ' - Estado: ' + $_.productState }"
    echo.
    echo ===== FIM DA VERIFICACAO =====
    pause
)
goto MENU

:EXP_21
call :INFO "[21] Testar conectividade com o Google" "Verifica se a rede esta conectada. Teste continuo (pressione Ctrl+C para parar)." "Continuo" "Nao"
if "%escolha%"=="1" (
    echo Iniciando ping continuo. Para parar pressione Ctrl+C.
    ping www.google.com -t
)
goto MENU

:EXP_22
call :INFO "[22] Backup dos logs de eventos" "Exporta logs de eventos para pasta BackupEventos." "1 a 2 minutos" "Nao"
if "%escolha%"=="1" (
    mkdir "%USERPROFILE%\BackupEventos" 2>nul
    for /F "tokens=*" %%G in ('wevtutil el') do wevtutil epl "%%G" "%USERPROFILE%\BackupEventos\%%G.evtx"
    echo Backup concluido!
)
pause
goto MENU

:EXP_23
call :INFO "[23] Visualizar dispositivos USB conectados" "Lista todos os dispositivos USB atualmente conectados." "Instantaneo" "Nao"
if "%escolha%"=="1" (
    powershell -NoProfile -Command "Get-CimInstance Win32_PnPEntity | Where-Object { $_.DeviceID -like 'USB*' } | Select-Object Name, DeviceID | Format-Table -AutoSize"
    pause
)
goto MENU

:EXP_24
cls
echo [24] Ver uso de memoria e CPU - Simples
echo ----------------------------------------
echo.
:: Memoria (via CIM/PowerShell - compativel com versoes recentes do Windows)
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize"`) do set MemTotalKB=%%A
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory"`) do set MemLivreKB=%%A

set /a MemTotalMB=MemTotalKB/1024
set /a MemLivreMB=MemLivreKB/1024
set /a MemUsadaMB=MemTotalMB-MemLivreMB
set /a MemPercent=(MemUsadaMB*100)/MemTotalMB

:: CPU
for /f "tokens=1 delims=." %%A in ('powershell -NoProfile -Command "try { [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue) } catch { 0 }"') do set CPU=%%A

:: Exibir resultado
echo Memoria: %MemUsadaMB% MB / %MemTotalMB% MB  [%MemPercent%%]
echo CPU: %CPU%%

echo.
pause
goto MENU

:EXP_25
cls
echo [25] Baixar arquivo via HTTPS (exemplo com PowerShell)
echo ------------------------------------------------
set /p "url=Cole o link HTTPS: "
if "%url%"=="" (
    echo Nenhum link fornecido!
    pause
    goto MENU
)
set "downloadPath=%USERPROFILE%\Downloads"
if not exist "%downloadPath%" mkdir "%downloadPath%"
for %%i in ("%url%") do set "filename=%%~nxi"
if "%filename%"=="" set "filename=downloaded_file"
set "destino=%downloadPath%\%filename%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%destino%'"
echo Download concluido em %destino%
pause
goto MENU

:EXP_26
call :INFO "[26] Gerar relatorio de politicas de grupo (gpresult)" "Mostra as politicas aplicadas e gera arquivo de relatorio." "Imediato" "Nao"
if "%escolha%"=="1" (
    cls
    echo Gerando relatorio de politicas de grupo...
    echo.
    gpresult /R
    echo.
    pause
)
goto MENU

:EXP_27
call :INFO "[27] Otimizador de Memoria (Swap/RAM)" "Abre submenu com ferramentas para liberar memoria RAM: fechar processos pesados, limpar temporarios, esvaziar lixeira, limpar standby list, reiniciar Explorer e otimizacao completa." "Variavel" "Pode fechar programas abertos (risco de perda de trabalho nao salvo)"
if not "%escolha%"=="1" goto MENU
call :LOG "Abriu Otimizador de Memoria (Swap/RAM)"
goto MENU_MEM

:MENU_MEM
cls
echo ===============================================================
echo            OTIMIZADOR DE MEMORIA WINDOWS (SWAP/RAM)
echo ===============================================================
echo.
echo [1] Exibir uso de memoria
echo [2] Fechar processos pesados (navegadores, Discord, Spotify, etc.)
echo [3] Limpar arquivos temporarios
echo [4] Esvaziar Lixeira
echo [5] Limpar Standby List (requer RAMMap.exe na pasta do painel)
echo [6] Reiniciar Windows Explorer
echo [7] Otimizacao Completa (executa 2 a 6 em sequencia)
echo [0] Voltar ao menu principal
echo.
set /p opmem="Escolha uma opcao: "

if "%opmem%"=="1" goto MEM_USO
if "%opmem%"=="2" goto MEM_PROCESSOS
if "%opmem%"=="3" goto MEM_TEMP
if "%opmem%"=="4" goto MEM_LIXEIRA
if "%opmem%"=="5" goto MEM_RAMMAP
if "%opmem%"=="6" goto MEM_EXPLORER
if "%opmem%"=="7" goto MEM_COMPLETO
if "%opmem%"=="0" goto MENU
goto MENU_MEM

:MEM_USO
cls
echo ================= USO DE MEMORIA =================
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize"`) do set MemTotalKB=%%A
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory"`) do set MemLivreKB=%%A

set /a MemTotalMB=MemTotalKB/1024
set /a MemLivreMB=MemLivreKB/1024
set /a MemUsadaMB=MemTotalMB-MemLivreMB
set /a MemPercent=(MemUsadaMB*100)/MemTotalMB

echo Memoria Total:  %MemTotalMB% MB
echo Memoria Livre:  %MemLivreMB% MB
echo Memoria Usada:  %MemUsadaMB% MB  [%MemPercent%%]
echo.
pause
goto MENU_MEM

:MEM_PROCESSOS
cls
call :LOG "Otimizador de Memoria: fechar processos pesados"
echo Fechando processos pesados...
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1
taskkill /F /IM firefox.exe >nul 2>&1
taskkill /F /IM opera.exe >nul 2>&1
taskkill /F /IM discord.exe >nul 2>&1
taskkill /F /IM spotify.exe >nul 2>&1
taskkill /F /IM Teams.exe >nul 2>&1
taskkill /F /IM steam.exe >nul 2>&1
taskkill /F /IM OneDrive.exe >nul 2>&1
echo.
echo Processos finalizados.
pause
goto MENU_MEM

:MEM_TEMP
cls
call :LOG "Otimizador de Memoria: limpar arquivos temporarios"
echo Limpando arquivos temporarios...

del /f /s /q "%temp%\*" >nul 2>&1
for /d %%x in ("%temp%\*") do rd /s /q "%%x" >nul 2>&1

del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1

echo.
echo Limpeza concluida.
pause
goto MENU_MEM

:MEM_LIXEIRA
cls
call :LOG "Otimizador de Memoria: esvaziar Lixeira"
echo Esvaziando Lixeira...
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force" >nul 2>&1
echo.
echo Lixeira esvaziada.
pause
goto MENU_MEM

:MEM_RAMMAP
cls
if exist "%~dp0RAMMap.exe" (
    call :LOG "Otimizador de Memoria: limpar Standby List (RAMMap)"
    echo Limpando Standby List...
    "%~dp0RAMMap.exe" -E
    echo.
    echo Memoria otimizada.
) else (
    echo.
    echo RAMMap.exe nao encontrado.
    echo Coloque o RAMMap.exe na mesma pasta deste painel.
)
pause
goto MENU_MEM

:MEM_EXPLORER
cls
call :LOG "Otimizador de Memoria: reiniciar Explorer"
echo Reiniciando Explorer...
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo.
echo Explorer reiniciado.
pause
goto MENU_MEM

:MEM_COMPLETO
cls
call :LOG "Otimizador de Memoria: otimizacao completa"
echo ================= OTIMIZACAO COMPLETA =================

echo.
echo [1/5] Fechando processos...
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1
taskkill /F /IM firefox.exe >nul 2>&1
taskkill /F /IM opera.exe >nul 2>&1
taskkill /F /IM discord.exe >nul 2>&1
taskkill /F /IM spotify.exe >nul 2>&1
taskkill /F /IM Teams.exe >nul 2>&1
taskkill /F /IM steam.exe >nul 2>&1
taskkill /F /IM OneDrive.exe >nul 2>&1

echo.
echo [2/5] Limpando arquivos temporarios...
del /f /s /q "%temp%\*" >nul 2>&1
for /d %%x in ("%temp%\*") do rd /s /q "%%x" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1

echo.
echo [3/5] Esvaziando Lixeira...
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force" >nul 2>&1

echo.
echo [4/5] Reiniciando Explorer...
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe

echo.
echo [5/5] Limpando Standby List...
if exist "%~dp0RAMMap.exe" (
    "%~dp0RAMMap.exe" -E
)

echo.
echo ===============================================================
echo            OTIMIZACAO CONCLUIDA COM SUCESSO
echo ===============================================================
pause
goto MENU_MEM

:: =====================================
:: ATUALIZACAO AUTOMATICA DO PAINEL
:: =====================================
:ATUALIZAR
cls
echo Atualizar o painel ira baixar a ultima versao do GitHub
echo e sobrescrever os arquivos locais.
call :CONFIRMAR
if errorlevel 1 goto MENU

echo Baixando ultima versao do GitHub...
set "ZIP_PATH=%TEMP%\painel_atualizado.zip"
set "TEMP_DIR=%TEMP%\painel_atualizado"

powershell -Command "Invoke-WebRequest -Uri '%GITHUB_REPO%' -OutFile '%ZIP_PATH%'"

if exist "%ZIP_PATH%" (
    echo Extraindo arquivos...
    if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"
    mkdir "%TEMP_DIR%"
    powershell -Command "Expand-Archive -Force -Path '%ZIP_PATH%' -DestinationPath '%TEMP_DIR%'"

    echo Atualizando arquivos do painel...
    xcopy "%TEMP_DIR%\painel_de_suporte-main\*" "%~dp0" /s /e /y

    echo.
    echo Atualizacao concluida em:
    echo ------------------------
    echo %date% %time%
    echo.
    
    echo Conteudo do painel updated:
    echo -----------------------------
    dir /b "%~dp0"
    echo.

    rd /s /q "%TEMP_DIR%"
    del /q "%ZIP_PATH%"
) else (
    echo Erro ao baixar o arquivo. Verifique sua conexao.
)
pause
goto MENU
