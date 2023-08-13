<meta http-equiv="refresh" content="5" />

<head>
  <title>Dashboard</title>
</head>

<?php

$userCpu = fopen('/tmp/cpuVariables/userCpu', 'r');
$idleCpu = fopen('/tmp/cpuVariables/idleCpu', 'r');

$totalMemory = fopen('/tmp/memoryVariables/totalMemory', 'r');
$availableMemory = fopen('/tmp/memoryVariables/availableMemory', 'r');

$systemLoad1min = fopen('/tmp/systemLoad/1min', 'r');
$systemLoad5min = fopen('/tmp/systemLoad/5min', 'r');
$systemLoad15min = fopen('/tmp/systemLoad/15min', 'r');

$diskSize = fopen('/tmp/diskVariables/diskSize', 'r');
$diskUsed = fopen('/tmp/diskVariables/diskUsed', 'r');

$rxTraffic = fopen('/tmp/networkVariables/rxTraffic', 'r');
$rxTrafficUnit = fopen('/tmp/networkVariables/rxTrafficUnit', 'r');
$txTraffic = fopen('/tmp/networkVariables/txTraffic', 'r');
$txTrafficUnit = fopen('/tmp/networkVariables/txTrafficUnit', 'r');

$processesByCpu = fopen('/tmp/listOfProcesses/processesByCpu', 'r');
$processesByMemory = fopen('/tmp/listOfProcesses/processesByMemory', 'r');

echo "User CPU Usage: " . fgets($userCpu) . "% &nbsp;&nbsp;&nbsp; CPU Idle: " . fgets($idleCpu) . "%<br>";
echo "RAM Usage: " . fgets($availableMemory) . "KB / " . fgets($totalMemory) . "KB<br>";
echo "System Load in 1 min: " . fgets($systemLoad1min) . 
        " &nbsp;&nbsp;&nbsp; in 5 min: " . fgets($systemLoad5min) . 
        " &nbsp;&nbsp;&nbsp; in 15 min: " . fgets($systemLoad15min) . "<br>";
echo "Disk Usage: " . fgets($diskUsed) . " / " . fgets($diskSize) . "<br><br>";

echo "Network: <br>";

echo "Receive Traffic: " . fgets($rxTraffic) . " " . fgets($rxTrafficUnit) . "<br>" .
        "Transmit Traffic: " . fgets($txTraffic) . " " . fgets($txTrafficUnit) . "<br><br>";

echo "Top 10 processes by CPU usage: <br><br>";
while(!feof($processesByCpu))
    echo fgets($processesByCpu) . "<br>";


echo "Top 10 processes by Memory usage: <br><br>";
while(!feof($processesByMemory))
    echo fgets($processesByMemory) . "<br>";


fclose($userCpu);
fclose($idleCpu);

fclose($totalMemory);
fclose($availableMemory);

fclose($systemLoad1min);
fclose($systemLoad5min);
fclose($systemLoad15min);

fclose($diskSize);
fclose($diskUsed);

fclose($rxTraffic);
fclose($rxTrafficUnit);
fclose($txTraffic);
fclose($txTrafficUnit);

fclose($processesByCpu);
fclose($processesByMemory);