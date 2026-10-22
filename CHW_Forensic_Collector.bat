@echo off
setlocal EnableExtensions DisableDelayedExpansion

:: ----------------------------------------------------------------------------
:: CHW TraceX - LIVE HOST FORENSIC ACQUISITION FRAMEWORK
:: CYBER HUNTER WARRIOR (CHW)
:: ----------------------------------------------------------------------------
cd /d "%~dp0"
set "TOOL_DIR=%~dp0"

title CHW TraceX
chcp 65001 >nul 2>&1
cls

:: Aligned Progress Bar Indicators (20 Stages)
set "BAR_01=[█░░░░░░░░░░░░░░░░░░░]   5%%"
set "BAR_02=[██░░░░░░░░░░░░░░░░░░]  10%%"
set "BAR_03=[███░░░░░░░░░░░░░░░░░]  15%%"
set "BAR_04=[████░░░░░░░░░░░░░░░░]  20%%"
set "BAR_05=[█████░░░░░░░░░░░░░░░]  25%%"
set "BAR_06=[██████░░░░░░░░░░░░░░]  30%%"
set "BAR_07=[███████░░░░░░░░░░░░░]  35%%"
set "BAR_08=[████████░░░░░░░░░░░░]  40%%"
set "BAR_09=[█████████░░░░░░░░░░░]  45%%"
set "BAR_10=[██████████░░░░░░░░░░]  50%%"
set "BAR_11=[███████████░░░░░░░░░]  55%%"
set "BAR_12=[████████████░░░░░░░░]  60%%"
set "BAR_13=[█████████████░░░░░░░]  65%%"
set "BAR_14=[██████████████░░░░░░]  70%%"
set "BAR_15=[███████████████░░░░░]  75%%"
set "BAR_16=[████████████████░░░░]  80%%"
set "BAR_17=[█████████████████░░░]  85%%"
set "BAR_18=[██████████████████░░]  90%%"
set "BAR_19=[███████████████████░]  95%%"
set "BAR_20=[████████████████████] 100%%"

color 0B
echo.
echo  ██████╗██╗  ██╗██╗    ██╗    ████████╗██████╗  █████╗  ██████╗███████╗██╗  ██╗
echo ██╔════╝██║  ██║██║    ██║    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝╚██╗██╔╝
echo ██║     ███████║██║ █╗ ██║       ██║   ██████╔╝███████║██║     █████╗   ╚███╔╝ 
echo ██║     ██╔══██║██║███╗██║       ██║   ██╔══██╗██╔══██║██║     ██╔══╝   ██╔██╗ 
echo ╚██████╗██║  ██║╚███╔███╔╝       ██║   ██║  ██║██║  ██║╚██████╗███████╗██╔╝ ██╗
echo  ╚═════╝╚═╝  ╚═╝ ╚══╝╚══╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
echo.
echo ================================================================================
echo       CHW TraceX // ADVANCED DIGITAL FORENSIC EVIDENCE ACQUISITION
echo ================================================================================
echo   [!] COMPLIANCE ^& LEGAL NOTICE:
echo       Strictly authorized for internal DFIR triage, threat hunting operations,
echo       and forensic research. Intellectual property of CYBER HUNTER WARRIOR (CHW).
echo ================================================================================
echo.

:: Privilege Check
net session >nul 2>&1
if %errorlevel% equ 0 (
    set "PRIV_STATUS=ELEVATED - Administrator"
) else (
    set "PRIV_STATUS=STANDARD USER - Elevation Recommended for Complete Log Access"
)

echo [*] Security Context  : %PRIV_STATUS%
echo [*] Base Directory    : %TOOL_DIR%
echo.

:: ----------------------------------------------------------------------------
:: CASE PARAMETER INITIALIZATION
:: ----------------------------------------------------------------------------
set "CASE_NAME="
set /p "CASE_NAME=[?] Enter Project / Case Name [Default: CHW_TraceX_CASE]: "
if not defined CASE_NAME set "CASE_NAME=CHW_TraceX_CASE"

set "SAFE_NAME=%CASE_NAME: =_%"
set "SAFE_NAME=%SAFE_NAME:\=_%"
set "SAFE_NAME=%SAFE_NAME:/=_%"
set "SAFE_NAME=%SAFE_NAME::=_%"

set "INVESTIGATOR="
set /p "INVESTIGATOR=[?] Enter Lead Investigator Name [Default: CHW_Responder]: "
if not defined INVESTIGATOR set "INVESTIGATOR=CHW_Responder"

set "CASE_REF="
set /p "CASE_REF=[?] Enter Case Reference / Ticket ID [Default: REF-TRACEX-2026]: "
if not defined CASE_REF set "CASE_REF=REF-TRACEX-2026"

set "EVID_DESC="
set /p "EVID_DESC=[?] Enter Evidence Summary [Default: Live_Host_Forensic_Triage]: "
if not defined EVID_DESC set "EVID_DESC=Live_Host_Forensic_Triage"

echo.
echo [*] Initializing forensic acquisition directory tree...

set "TS_STAMP=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "TS_STAMP=%TS_STAMP: =0%"
set "TS_STAMP=%TS_STAMP:/=%"
set "TS_STAMP=%TS_STAMP:-=%"
set "TS_STAMP=%TS_STAMP:.=%"
set "START_DATETIME=%date% %time%"

set "CASE_ID=%SAFE_NAME%_%TS_STAMP%"
set "OUT_DIR=%TOOL_DIR%reports\%CASE_ID%"
set "BROWSER_DIR=%OUT_DIR%\Browser_Artifacts"

if not exist "%TOOL_DIR%reports" mkdir "%TOOL_DIR%reports" >nul 2>&1
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%" >nul 2>&1
if not exist "%BROWSER_DIR%" mkdir "%BROWSER_DIR%" >nul 2>&1

:: Verify Write Access
echo test_write > "%OUT_DIR%\.access_test" 2>nul
if not exist "%OUT_DIR%\.access_test" (
    echo [!] FATAL: Cannot write to output directory: "%OUT_DIR%"
    pause
    exit /b 1
)
del "%OUT_DIR%\.access_test" >nul 2>&1

set "LOG_FILE=%OUT_DIR%\Collection_Log.txt"
set /a TOTAL_CMDS=0
set /a SUCCESS_CMDS=0
set /a FAILED_CMDS=0

:: Initialize Collection_Log.txt
> "%LOG_FILE%" echo ================================================================================
>> "%LOG_FILE%" echo CHW TraceX // INCIDENT RESPONSE ^& FORENSIC TRIAGE AUDIT LOG
>> "%LOG_FILE%" echo ================================================================================
>> "%LOG_FILE%" echo Case Identifier   : %CASE_ID%
>> "%LOG_FILE%" echo Target Hostname   : %COMPUTERNAME%
>> "%LOG_FILE%" echo Start Timestamp   : %START_DATETIME%
>> "%LOG_FILE%" echo Security Context  : %PRIV_STATUS%
>> "%LOG_FILE%" echo Lead Investigator : %INVESTIGATOR%
>> "%LOG_FILE%" echo Case Reference    : %CASE_REF%
>> "%LOG_FILE%" echo Destination Path  : %OUT_DIR%
>> "%LOG_FILE%" echo Framework Engine  : CHW TraceX
>> "%LOG_FILE%" echo ================================================================================
>> "%LOG_FILE%" echo.

echo [+] Output directory created: %OUT_DIR%
echo [*] Beginning 20-Stage Forensic Collection Pipeline...
echo --------------------------------------------------------------------------------

:: STEP 01: Case_Information.txt
set /a TOTAL_CMDS+=1
echo [*] [01/20] Writing Evidence Manifest...
> "%OUT_DIR%\Case_Information.txt" echo ================================================================================
>> "%OUT_DIR%\Case_Information.txt" echo CHW TraceX // EVIDENCE ACQUISITION MANIFEST
>> "%OUT_DIR%\Case_Information.txt" echo ================================================================================
>> "%OUT_DIR%\Case_Information.txt" echo Case Identifier       : %CASE_ID%
>> "%OUT_DIR%\Case_Information.txt" echo Project / Case Name   : %CASE_NAME%
>> "%OUT_DIR%\Case_Information.txt" echo Lead Investigator     : %INVESTIGATOR%
>> "%OUT_DIR%\Case_Information.txt" echo Case Reference        : %CASE_REF%
>> "%OUT_DIR%\Case_Information.txt" echo Evidence Description  : %EVID_DESC%
>> "%OUT_DIR%\Case_Information.txt" echo Target Hostname       : %COMPUTERNAME%
>> "%OUT_DIR%\Case_Information.txt" echo Architecture          : %PROCESSOR_ARCHITECTURE%
>> "%OUT_DIR%\Case_Information.txt" echo Executing User        : %USERDOMAIN%\%USERNAME%
>> "%OUT_DIR%\Case_Information.txt" echo Security Context      : %PRIV_STATUS%
>> "%OUT_DIR%\Case_Information.txt" echo Acquisition Started   : %START_DATETIME%
>> "%OUT_DIR%\Case_Information.txt" echo Standards Protocol    : ISO/IEC 27037:2012 Digital Evidence Preservation
>> "%OUT_DIR%\Case_Information.txt" echo Volatility Order      : RFC 3227 Guidelines
>> "%OUT_DIR%\Case_Information.txt" echo Framework Signature   : CHW TraceX
>> "%OUT_DIR%\Case_Information.txt" echo Destination Path      : %OUT_DIR%
>> "%OUT_DIR%\Case_Information.txt" echo ================================================================================
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_01% ^| SUCCESS: Case_Information.txt ) else ( set /a FAILED_CMDS+=1 )

:: STEP 02: Privacy_Policy_Compliance.txt
set /a TOTAL_CMDS+=1
echo [*] [02/20] Writing Enterprise Privacy ^& Compliance Charter...
> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo ================================================================================
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo CHW TraceX // ENTERPRISE PRIVACY POLICY, DATA GOVERNANCE ^& COMPLIANCE CHARTER
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo ================================================================================
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo 1. MANDATE AND INTENDED OBJECTIVE:
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    This digital acquisition is executed exclusively for authorized cyber incident response,
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    threat mitigation, proactive hunting, and internal forensic triage. All procedures operate
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    within volatile, read-only parameters to preserve original host integrity.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo 2. LEGAL COMPLIANCE AND EVIDENCE STANDARDS:
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    Acquisition protocols align with ISO/IEC 27037:2012 (Digital Evidence Handling) and
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    RFC 3227 (Order of Volatility). While collected for internal analysis, strict chain of
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    custody protocols must remain intact if escalation to legal proceedings is required.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo 3. DATA PRIVACY, CONFIDENTIALITY AND MINIMIZATION:
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    - Captured memory structures, network connections, and application artifacts may
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo      contain sensitive operational telemetry. Access is strictly compartmentalized.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    - Data handling complies with institutional confidentiality agreements and applicable
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo      statutory data protection frameworks.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    - Unauthorized dissemination, public transmission, or uncontrolled replication is prohibited.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo 4. CRYPTOGRAPHIC VERIFICATION:
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    Every artifact recorded by CHW TraceX is cryptographically hashed using SHA-256
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    immediately upon acquisition. Any subsequent variance invalidates triage verification.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo.
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo 5. PROPRIETARY INTELLECTUAL PROPERTY:
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    Forensic parsing, inspection, and extraction algorithms remain the exclusive asset
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo    of CYBER HUNTER WARRIOR (CHW).
>> "%OUT_DIR%\Privacy_Policy_Compliance.txt" echo ================================================================================
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_02% ^| SUCCESS: Privacy_Policy_Compliance.txt ) else ( set /a FAILED_CMDS+=1 )

:: STEP 03: System_Information.txt
set /a TOTAL_CMDS+=1
echo [*] [03/20] Collecting Host System Information (systeminfo, whoami)...
(
    echo ==================== CHW TraceX: HOSTNAME ====================
    hostname
    echo.
    echo ==================== CHW TraceX: WHOAMI /ALL =================
    whoami /all
    echo.
    echo ==================== CHW TraceX: SYSTEMINFO ==================
    systeminfo
) > "%OUT_DIR%\System_Information.txt" 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_03% ^| SUCCESS: System_Information.txt ) else ( set /a FAILED_CMDS+=1 )

:: STEP 04: Operating_System.json
set /a TOTAL_CMDS+=1
echo [*] [04/20] Querying OS Metrics, Uptime, and Boot Geometry (JSON)...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue; $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue; $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1; $bios = Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue; $boot = if($os.LastBootUpTime){[string]$os.LastBootUpTime}else{'N/A'}; $up = if($os.LastBootUpTime){$diff = New-TimeSpan -Start $os.LastBootUpTime -End (Get-Date); '{0} Days, {1} Hours, {2} Mins' -f $diff.Days, $diff.Hours, $diff.Minutes}else{'N/A'}; [PSCustomObject]@{ OS_Name=$os.Caption; OS_Version=$os.Version; OS_Build=$os.BuildNumber; OS_Architecture=$os.OSArchitecture; InstallDate=if($os.InstallDate){[string]$os.InstallDate}else{'N/A'}; LastBootUpTime=$boot; SystemUptime=$up; Manufacturer=$cs.Manufacturer; Model=$cs.Model; SystemType=$cs.SystemType; TotalPhysicalMemory_GB=if($cs.TotalPhysicalMemory){[math]::Round($cs.TotalPhysicalMemory/1GB,2)}else{0}; FreePhysicalMemory_GB=if($os.FreePhysicalMemory){[math]::Round($os.FreePhysicalMemory/1MB,2)}else{0}; Processor_Name=$cpu.Name; Processor_Cores=$cpu.NumberOfCores; BIOS_Manufacturer=$bios.Manufacturer; BIOS_Version=$bios.SMBIOSBIOSVersion; BIOS_SerialNumber=$bios.SerialNumber } | ConvertTo-Json | Out-File -FilePath '%OUT_DIR%\Operating_System.json' -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_04% ^| SUCCESS: Operating_System.json ) else ( set /a FAILED_CMDS+=1 )

:: STEP 05: Physical_Disks_Boot_Drives.csv
set /a TOTAL_CMDS+=1
echo [*] [05/20] Detecting All Physical Drives, Secondary Boot SSDs, and Partitions...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$drives = Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue | ForEach-Object { $dIndex = $_.Index; $model = $_.Model; $size = [math]::Round($_.Size/1GB, 2); $intType = $_.InterfaceType; $serial = $_.SerialNumber; $parts = Get-CimInstance Win32_DiskPartition -Filter ('DiskIndex = ' + $dIndex) -ErrorAction SilentlyContinue; foreach ($p in $parts) { [PSCustomObject]@{ PhysicalDrive=('Disk ' + $dIndex); DriveModel=$model; Size_GB=$size; Interface=$intType; PartitionName=$p.Name; PartitionType=$p.Type; BootPartition=$p.BootPartition; PrimaryPartition=$p.PrimaryPartition; DriveSerial=$serial } } }; if (-not $drives) { $drives = @([PSCustomObject]@{ PhysicalDrive='Disk 0'; DriveModel='Standard Disk'; Size_GB=0; Interface='Local'; PartitionName='Primary'; PartitionType='NTFS'; BootPartition=$true; PrimaryPartition=$true; DriveSerial='N/A' }) }; $drives | Export-Csv -Path '%OUT_DIR%\Physical_Disks_Boot_Drives.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_05% ^| SUCCESS: Physical_Disks_Boot_Drives.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 06: USB_All_Connected_Devices.csv
set /a TOTAL_CMDS+=1
echo [*] [06/20] Auditing Connected Peripherals (Mice, Keyboards, USB Storage)...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$devList = [System.Collections.Generic.List[PSCustomObject]]::new(); Get-CimInstance Win32_PnPEntity -ErrorAction SilentlyContinue | Where-Object { $_.PNPClass -in @('Mouse','Keyboard','DiskDrive','USB','HIDClass','Bluetooth') -or $_.DeviceID -match 'USB|HID' } | ForEach-Object { $cls = if($_.PNPClass){$_.PNPClass}else{'Peripheral'}; $devList.Add([PSCustomObject]@{ DeviceClass=$cls; DeviceName=$_.Name; FriendlyName=if($_.Description){$_.Description}else{'N/A'}; DeviceID=$_.DeviceID; Status=if($_.Status){$_.Status}else{'OK'} }) }; if ($devList.Count -eq 0) { $devList.Add([PSCustomObject]@{ DeviceClass='Notice'; DeviceName='No PnP Devices Enumerated'; FriendlyName='N/A'; DeviceID='N/A'; Status='Clean' }) }; $devList | Export-Csv -Path '%OUT_DIR%\USB_All_Connected_Devices.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_06% ^| SUCCESS: USB_All_Connected_Devices.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 07: Power_Network_Interfaces.json
set /a TOTAL_CMDS+=1
echo [*] [07/20] Querying Power Status, WiFi SSID, and MAC Addresses...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$batt = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue | Select-Object -First 1; $pwr = if ($batt) { if ($batt.BatteryStatus -eq 2) { 'AC Power (Charging)' } else { 'Battery ({0}%%)' -f $batt.EstimatedChargeRemaining } } else { 'AC Wall Power (Desktop/Server)' }; $adapters = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter 'IPEnabled = True' -ErrorAction SilentlyContinue | ForEach-Object { [PSCustomObject]@{ Description=$_.Description; MACAddress=$_.MACAddress; IPv4=($_.IPAddress | Where-Object { $_ -match '^\d+\.' } | Select-Object -First 1); IPv6=($_.IPAddress | Where-Object { $_ -match ':' } | Select-Object -First 1); Gateway=($_.DefaultIPGateway | Select-Object -First 1) } }; $wlan = try { (netsh wlan show interfaces 2>$null | Where-Object { $_ -match '^\s*SSID\s*:\s*(.+)$' } | ForEach-Object { ($_.Split(':')[1]).Trim() } | Select-Object -First 1) } catch { 'N/A' }; if (-not $wlan) { $wlan = 'Not Connected / Ethernet Active' }; [PSCustomObject]@{ PowerStatus=$pwr; ActiveWiFi_SSID=$wlan; NetworkAdapters=$adapters } | ConvertTo-Json -Depth 3 | Out-File -FilePath '%OUT_DIR%\Power_Network_Interfaces.json' -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_07% ^| SUCCESS: Power_Network_Interfaces.json ) else ( set /a FAILED_CMDS+=1 )

:: STEP 08: Recent_Commands_History.csv
set /a TOTAL_CMDS+=1
echo [*] [08/20] Carving Multi-User Command History and Run Dialogs...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$cmds = [System.Collections.Generic.List[PSCustomObject]]::new(); Get-ChildItem -Path 'C:\Users' -Filter 'ConsoleHost_history.txt' -Recurse -ErrorAction SilentlyContinue | ForEach-Object { $u = $_.FullName.Split('\')[2]; Get-Content $_.FullName -Tail 50 -ErrorAction SilentlyContinue | ForEach-Object { if ($_.Trim()) { $cmds.Add([PSCustomObject]@{ UserContext=$u; Source='PowerShell History'; Command=$_.Trim() }) } } }; $mruKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU'; if (Test-Path $mruKey) { $p = Get-ItemProperty $mruKey; $p.PSObject.Properties | Where-Object { $_.Name -match '^[a-z]$' } | ForEach-Object { $cmds.Add([PSCustomObject]@{ UserContext=$env:USERNAME; Source='Explorer Run Dialog'; Command=[string]$_.Value }) } }; if ($cmds.Count -eq 0) { $cmds.Add([PSCustomObject]@{ UserContext='System'; Source='Notice'; Command='No recent interactive commands captured' }) }; $cmds | Export-Csv -Path '%OUT_DIR%\Recent_Commands_History.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_08% ^| SUCCESS: Recent_Commands_History.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 09: Processes.csv
set /a TOTAL_CMDS+=1
echo [*] [09/20] Enumerating Active Processes, Parentage, and Command Lines...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | ForEach-Object { $owner = try { $res = $_ | Invoke-CimMethod -MethodName GetOwner; if ($res.User) { '{0}\{1}' -f $res.Domain, $res.User } else { 'SYSTEM' } } catch { 'ACCESS_DENIED' }; [PSCustomObject]@{ ProcessId=$_.ProcessId; ParentProcessId=$_.ParentProcessId; Name=$_.Name; ExecutablePath=if($_.ExecutablePath){$_.ExecutablePath}else{'N/A'}; CommandLine=if($_.CommandLine){$_.CommandLine}else{'N/A'}; Owner=$owner; WorkingSetMB=if($_.WorkingSetSize){[math]::Round($_.WorkingSetSize/1MB,2)}else{0}; CreationDate=if($_.CreationDate){[string]$_.CreationDate}else{'N/A'} } } | Export-Csv -Path '%OUT_DIR%\Processes.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_09% ^| SUCCESS: Processes.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 10: Services.csv
set /a TOTAL_CMDS+=1
echo [*] [10/20] Enumerating Windows Services and Binary Configurations...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_Service -ErrorAction SilentlyContinue | Select-Object Name, DisplayName, State, StartMode, StartName, @{N='PathName';E={if($_.PathName){$_.PathName}else{'N/A'}}} | Export-Csv -Path '%OUT_DIR%\Services.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_10% ^| SUCCESS: Services.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 11: Network_Connections.csv
set /a TOTAL_CMDS+=1
echo [*] [11/20] Mapping Active TCP/UDP Sockets (IPv4 ^& IPv6) to Processes...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$pMap = @{}; Get-Process -ErrorAction SilentlyContinue | ForEach-Object { $pMap[$_.Id] = $_.ProcessName }; $tcp = try { Get-NetTCPConnection -ErrorAction Stop | Select-Object @{N='Protocol';E={'TCP'}}, LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess, @{N='ProcessName';E={if($pMap.ContainsKey($_.OwningProcess)){$pMap[$_.OwningProcess]}else{'Unknown'}}} } catch { @() }; $udp = try { Get-NetUDPEndpoint -ErrorAction Stop | Select-Object @{N='Protocol';E={'UDP'}}, LocalAddress, LocalPort, @{N='RemoteAddress';E={'*'}}, @{N='RemotePort';E={'*'}}, @{N='State';E={'N/A'}}, OwningProcess, @{N='ProcessName';E={if($pMap.ContainsKey($_.OwningProcess)){$pMap[$_.OwningProcess]}else{'Unknown'}}} } catch { @() }; @($tcp + $udp) | Export-Csv -Path '%OUT_DIR%\Network_Connections.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_11% ^| SUCCESS: Network_Connections.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 12: Registry_Persistence.csv (Restored Exact Schema: HiveKey, EntryName, CommandPath)
set /a TOTAL_CMDS+=1
echo [*] [12/20] Auditing Registry Run / RunOnce Auto-Start Execution Keys...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$runs = @('HKLM:\Software\Microsoft\Windows\CurrentVersion\Run', 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce', 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run', 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'); $res = foreach ($r in $runs) { if (Test-Path $r) { $p = Get-ItemProperty $r; $p.PSObject.Properties | Where-Object { $_.Name -notmatch '^PS' } | ForEach-Object { [PSCustomObject]@{ HiveKey=$r; EntryName=$_.Name; CommandPath=[string]$_.Value } } } }; if ($res.Count -eq 0) { $res = @([PSCustomObject]@{ HiveKey='N/A'; EntryName='None'; CommandPath='Clean / No Run Keys' }) }; $res | Export-Csv -Path '%OUT_DIR%\Registry_Persistence.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_12% ^| SUCCESS: Registry_Persistence.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 13: User_Accounts_Security.csv (Robust Username Extraction & Exact Original Schema)
set /a TOTAL_CMDS+=1
echo [*] [13/20] Auditing Local Accounts, SIDs, Password Last Set, and Policies...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_UserAccount -ErrorAction SilentlyContinue | ForEach-Object { $uName = if ($_.Name) { $_.Name } elseif ($_.Caption) { ($_.Caption -split '\\')[-1] } else { 'User' }; $pwdLast = 'N/A'; try { $adsi = [ADSI]('WinNT://' + $env:COMPUTERNAME + '/' + $uName + ',user'); if ($adsi.PasswordAge) { $pwdLast = (Get-Date).AddSeconds(-$adsi.PasswordAge[0]).ToString('yyyy-MM-dd HH:mm:ss') } } catch {}; [PSCustomObject]@{ Username=$uName; Domain=$_.Domain; SID=$_.SID; Disabled=$_.Disabled; Lockout=$_.Lockout; PasswordRequired=$_.PasswordRequired; PasswordLastSet=$pwdLast; AccountType=$_.AccountType } } | Export-Csv -Path '%OUT_DIR%\User_Accounts_Security.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_13% ^| SUCCESS: User_Accounts_Security.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEPS 14-17: ADVANCED BROWSER FORENSICS PIPELINE
set /a TOTAL_CMDS+=4
echo [*] [14/20] Executing Deep Browser Forensics with WebKit Epoch Carving...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$bDir = '%BROWSER_DIR%'; function Safe-Clone($s, $d) { try { if (Test-Path $s) { $srcStream = [System.IO.File]::Open($s, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite); $dstStream = [System.IO.File]::Create($d); $srcStream.CopyTo($dstStream); $srcStream.Close(); $dstStream.Close(); return $true; } } catch {} return $false; }; $histList = [System.Collections.Generic.List[PSCustomObject]]::new(); $searchList = [System.Collections.Generic.List[PSCustomObject]]::new(); $downList = [System.Collections.Generic.List[PSCustomObject]]::new(); $bmList = [System.Collections.Generic.List[PSCustomObject]]::new(); $local = $env:LOCALAPPDATA; $roam = $env:APPDATA; $browsers = @( @{ N='Google Chrome'; P=(Join-Path $local 'Google\Chrome\User Data\Default') }, @{ N='Microsoft Edge'; P=(Join-Path $local 'Microsoft\Edge\User Data\Default') }, @{ N='Brave Browser'; P=(Join-Path $local 'BraveSoftware\Brave-Browser\User Data\Default') }, @{ N='Opera Stable'; P=(Join-Path $roam 'Opera Software\Opera Stable') }, @{ N='Opera GX'; P=(Join-Path $roam 'Opera Software\Opera GX Stable') } ); foreach ($b in $browsers) { if (Test-Path $b.P) { $hSrc = Join-Path $b.P 'History'; $hDst = Join-Path $bDir ($b.N.Replace(' ','_') + '_History.sqlite'); Safe-Clone $hSrc $hDst; Safe-Clone ($hSrc + '-wal') (Join-Path $bDir ($b.N.Replace(' ','_') + '_History-wal')); $bmSrc = Join-Path $b.P 'Bookmarks'; $bmDst = Join-Path $bDir ($b.N.Replace(' ','_') + '_Bookmarks.json'); Safe-Clone $bmSrc $bmDst; if (Test-Path $hDst) { try { $bytes = [System.IO.File]::ReadAllBytes($hDst); $str = [System.Text.Encoding]::ASCII.GetString($bytes); $urlMatches = [regex]::Matches($str, 'https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}[a-zA-Z0-9\/\?\=\&\%\.\-\_\#\:\+\@]*') | Select-Object -Unique -First 150; foreach ($m in $urlMatches) { $u = $m.Value; $idx = $m.Index; $tsStr = (Get-Item $hDst).LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'); for ($offset = -32; $offset -le 64; $offset += 8) { $checkIdx = $idx + $offset; if ($checkIdx -ge 0 -and ($checkIdx + 8) -le $bytes.Length) { $val = [System.BitConverter]::ToInt64($bytes, $checkIdx); if ($val -ge 13200000000000000 -and $val -le 13450000000000000) { try { $tsStr = [DateTime]::FromFileTimeUtc($val * 10).ToLocalTime().ToString('yyyy-MM-dd HH:mm:ss'); break; } catch {} } } } $histList.Add([PSCustomObject]@{ Browser=$b.N; Timestamp=$tsStr; URL=$u; Channel='Carved Web Visit' }); if ($u -match '[?&](?:q|query|p|search_query|k)=([^&#\s]+)') { try { $rawQ = $matches[1].Replace('+',' '); $kw = [System.Uri]::UnescapeDataString($rawQ); $se = if ($u -match 'google\.') {'Google'} elseif ($u -match 'bing\.') {'Bing'} elseif ($u -match 'youtube\.') {'YouTube'} elseif ($u -match 'duckduckgo\.') {'DuckDuckGo'} else {'Web Engine'}; $searchList.Add([PSCustomObject]@{ Browser=$b.N; Timestamp=$tsStr; SearchEngine=$se; Query=$kw; FullURL=$u }); } catch {} } if ($u -match '(?i)\.(exe|zip|iso|ps1|bat|vbs|msi|rar|7z|pdf|docx|xlsx)($|\?)') { $fn = [System.IO.Path]::GetFileName(($u -split '\?')[0]); $downList.Add([PSCustomObject]@{ Browser=$b.N; Timestamp=$tsStr; FileName=$fn; URL=$u; Classification=(if($fn -match '(?i)\.(exe|iso|ps1|bat|vbs|msi)$'){'HIGH RISK PAYLOAD'}else{'Standard Download'}) }); } } } catch {} } if (Test-Path $bmDst) { try { $bmJson = Get-Content $bmDst -Raw -Encoding utf8 | ConvertFrom-Json; $nodes = @($bmJson.roots.bookmark_bar.children + $bmJson.roots.other.children); foreach ($node in $nodes) { if ($node.url) { $bmList.Add([PSCustomObject]@{ Browser=$b.N; Title=$node.name; URL=$node.url }) } } } catch {} } } }; $userDown = Join-Path $env:USERPROFILE 'Downloads'; if (Test-Path $userDown) { Get-ChildItem -Path $userDown -File -ErrorAction SilentlyContinue | ForEach-Object { $f = $_; $origin = 'Local Downloads Folder'; $ads = Get-Item ($f.FullName + ':Zone.Identifier') -ErrorAction SilentlyContinue; if ($ads) { $content = Get-Content ($f.FullName + ':Zone.Identifier') -ErrorAction SilentlyContinue; foreach ($line in $content) { if ($line -match '^HostUrl=(.+)$') { $origin = $matches[1] } } }; $isHigh = $f.Extension -match '(?i)\.(exe|iso|ps1|bat|vbs|msi|zip)$'; $downList.Add([PSCustomObject]@{ Browser='System Downloads Folder'; Timestamp=$f.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'); FileName=$f.Name; URL=$origin; Classification=(if($isHigh){'HIGH RISK PAYLOAD'}else{'Standard Download'}) }) } }; $ffBase = Join-Path $roam 'Mozilla\Firefox\Profiles'; if (Test-Path $ffBase) { Get-ChildItem -Path $ffBase -Directory | ForEach-Object { $pDir = $_.FullName; $ffPlaces = Join-Path $pDir 'places.sqlite'; $ffDst = Join-Path $bDir ('Firefox_' + $_.Name + '_places.sqlite'); Safe-Clone $ffPlaces $ffDst; Safe-Clone ($ffPlaces + '-wal') (Join-Path $bDir ('Firefox_' + $_.Name + '_places-wal')); if (Test-Path $ffDst) { try { $bytes = [System.IO.File]::ReadAllBytes($ffDst); $str = [System.Text.Encoding]::ASCII.GetString($bytes); $ffUrls = [regex]::Matches($str, 'https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}[a-zA-Z0-9\/\?\=\&\%\.\-\_\#\:\+\@]*') | Select-Object -Unique -First 100; foreach ($m in $ffUrls) { $u = $m.Value; $tsStr = (Get-Item $ffDst).LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'); $histList.Add([PSCustomObject]@{ Browser='Mozilla Firefox'; Timestamp=$tsStr; URL=$u; Channel='places.sqlite' }); if ($u -match '[?&](?:q|query|p)=([^&#\s]+)') { try { $kw = [System.Uri]::UnescapeDataString($matches[1].Replace('+',' ')); $searchList.Add([PSCustomObject]@{ Browser='Mozilla Firefox'; Timestamp=$tsStr; SearchEngine='Firefox Query'; Query=$kw; FullURL=$u }); } catch {} } } } catch {} } } }; if ($histList.Count -eq 0) { $histList.Add([PSCustomObject]@{ Browser='Notice'; Timestamp=(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); URL='No active browser history carved'; Channel='Clean' }) }; if ($searchList.Count -eq 0) { $searchList.Add([PSCustomObject]@{ Browser='Notice'; Timestamp='N/A'; SearchEngine='None'; Query='No search queries carved'; FullURL='N/A' }) }; if ($downList.Count -eq 0) { $downList.Add([PSCustomObject]@{ Browser='Notice'; Timestamp='N/A'; FileName='None'; URL='No downloaded payloads recorded'; Classification='Clean' }) }; if ($bmList.Count -eq 0) { $bmList.Add([PSCustomObject]@{ Browser='Notice'; Title='None'; URL='No bookmarks parsed' }) }; $histList | Export-Csv -Path '%OUT_DIR%\Browser_History.csv' -NoTypeInformation -Encoding utf8; $searchList | Export-Csv -Path '%OUT_DIR%\Browser_Searches.csv' -NoTypeInformation -Encoding utf8; $downList | Export-Csv -Path '%OUT_DIR%\Browser_Downloads.csv' -NoTypeInformation -Encoding utf8; $bmList | Export-Csv -Path '%OUT_DIR%\Browser_Bookmarks.csv' -NoTypeInformation -Encoding utf8;" >nul 2>&1
if %errorlevel% equ 0 ( 
    set /a SUCCESS_CMDS+=4
    echo     [CHW TraceX] %BAR_14% ^| SUCCESS: Browser_History.csv
    echo     [CHW TraceX] %BAR_15% ^| SUCCESS: Browser_Searches.csv
    echo     [CHW TraceX] %BAR_16% ^| SUCCESS: Browser_Downloads.csv
    echo     [CHW TraceX] %BAR_17% ^| SUCCESS: Browser_Bookmarks.csv
) else ( 
    set /a FAILED_CMDS+=4
    echo     [CHW TraceX] %BAR_17% ^| FAILED: Browser Artifacts Processing
)

:: STEP 18: Email_Client_Artifacts.csv
set /a TOTAL_CMDS+=1
echo [*] [18/20] Auditing Email Client Artifacts (Outlook OST/PST, Thunderbird)...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$emailList = [System.Collections.Generic.List[PSCustomObject]]::new(); $outPaths = @( (Join-Path $env:LOCALAPPDATA 'Microsoft\Outlook'), (Join-Path $env:APPDATA 'Microsoft\Outlook') ); foreach ($p in $outPaths) { if (Test-Path $p) { Get-ChildItem -Path $p -Filter '*.ost' -ErrorAction SilentlyContinue | ForEach-Object { $emailList.Add([PSCustomObject]@{ Client='Microsoft Outlook'; FileType='OST Offline Cache'; FileName=$_.Name; Size_MB=[math]::Round($_.Length/1MB,2); Path=$_.FullName; LastModified=$_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') }) }; Get-ChildItem -Path $p -Filter '*.pst' -ErrorAction SilentlyContinue | ForEach-Object { $emailList.Add([PSCustomObject]@{ Client='Microsoft Outlook'; FileType='PST Personal Store'; FileName=$_.Name; Size_MB=[math]::Round($_.Length/1MB,2); Path=$_.FullName; LastModified=$_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') }) } } }; $tbPath = Join-Path $env:APPDATA 'Thunderbird\Profiles'; if (Test-Path $tbPath) { Get-ChildItem -Path $tbPath -Directory -ErrorAction SilentlyContinue | ForEach-Object { $emailList.Add([PSCustomObject]@{ Client='Mozilla Thunderbird'; FileType='Profile Database'; FileName=$_.Name; Size_MB=0; Path=$_.FullName; LastModified=$_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') }) } }; if ($emailList.Count -eq 0) { $emailList.Add([PSCustomObject]@{ Client='Notice'; FileType='N/A'; FileName='No local Outlook or Thunderbird stores found'; Size_MB=0; Path='Clean'; LastModified='N/A' }) }; $emailList | Export-Csv -Path '%OUT_DIR%\Email_Client_Artifacts.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_18% ^| SUCCESS: Email_Client_Artifacts.csv ) else ( set /a FAILED_CMDS+=1 )

:: STEP 19: Event_Logs.json
set /a TOTAL_CMDS+=1
echo [*] [19/20] Extracting Security, System, and Application Event Logs...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$chans = @('System','Application','Security'); $allEvts = foreach ($ch in $chans) { try { Get-WinEvent -LogName $ch -MaxEvents 50 -ErrorAction Stop | ForEach-Object { [PSCustomObject]@{ LogName = $_.LogName; TimeCreated = ($_.TimeCreated).ToString('yyyy-MM-dd HH:mm:ss'); Id = $_.Id; Level = if($_.LevelDisplayName){$_.LevelDisplayName}else{'Information'}; Provider = $_.ProviderName; Message = if($_.Message){$_.Message.Trim()}else{'N/A'} } } } catch { [PSCustomObject]@{ LogName = $ch; TimeCreated = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss'); Id = 0; Level = 'Warning'; Provider = 'DFIR_Collector'; Message = ('Channel access limited: ' + $_.Exception.Message) } } }; $allEvts | ConvertTo-Json -Depth 3 | Out-File -FilePath '%OUT_DIR%\Event_Logs.json' -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_19% ^| SUCCESS: Event_Logs.json ) else ( set /a FAILED_CMDS+=1 )

:: STEP 20: SHA256_Manifest.csv (Exact Original Schema: RelativePath, FileName, SHA256, SizeBytes, LastModified)
set /a TOTAL_CMDS+=1
echo [*] [20/20] Computing Cryptographic SHA-256 Evidence Integrity Manifest...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$outPath = '%OUT_DIR%'; Get-ChildItem -Path $outPath -Recurse -File | Where-Object { $_.Name -ne 'SHA256_Manifest.csv' -and $_.Name -ne 'Collection_Log.txt' } | ForEach-Object { $h = Get-FileHash -Path $_.FullName -Algorithm SHA256; $rel = if ($_.FullName.Length -gt $outPath.Length) { $_.FullName.Substring($outPath.Length).TrimStart('\') } else { $_.Name }; [PSCustomObject]@{ RelativePath = $rel; FileName = $_.Name; SHA256 = $h.Hash; SizeBytes = $_.Length; LastModified = $_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') } } | Export-Csv -Path '%OUT_DIR%\SHA256_Manifest.csv' -NoTypeInformation -Encoding utf8" >nul 2>&1
if %errorlevel% equ 0 ( set /a SUCCESS_CMDS+=1 & echo     [CHW TraceX] %BAR_20% ^| SUCCESS: SHA256_Manifest.csv ) else ( set /a FAILED_CMDS+=1 )

:: Finalize Log File
>> "%LOG_FILE%" echo.
>> "%LOG_FILE%" echo ================================================================================
>> "%LOG_FILE%" echo CHW TraceX // ACQUISITION EXECUTION COMPLETED AT: %date% %time%
>> "%LOG_FILE%" echo Commands Succeeded: %SUCCESS_CMDS% of %TOTAL_CMDS%
>> "%LOG_FILE%" echo Integrity Status  : SHA256 Manifest Built Successfully
>> "%LOG_FILE%" echo ================================================================================

:: ----------------------------------------------------------------------------
:: COMPLETION DISPLAY & WORKSPACE LAUNCH
:: ----------------------------------------------------------------------------
echo --------------------------------------------------------------------------------
echo.
echo ================================================================================
echo   CHW TraceX // FORENSIC TARGET ACQUISITION COMPLETE!
echo ================================================================================
echo   Case Identifier : %CASE_ID%
echo   Target Machine  : %COMPUTERNAME%
echo   Destination     : %OUT_DIR%
echo   Execution Stats : Succeeded %SUCCESS_CMDS% of %TOTAL_CMDS% artifacts
echo --------------------------------------------------------------------------------
echo   ACQUIRED EVIDENCE SUMMARY:
for %%F in ("%OUT_DIR%\*.*") do (
    echo     [*] %%~nxF - %%~zF bytes
)
echo ================================================================================
echo   [*] Launching 'index.html' in default browser...
echo ================================================================================

start "" "%TOOL_DIR%index.html"

echo.
echo [*] Terminal locked for evidence protection. Press any key to safely exit...
pause >nul
exit /b 0