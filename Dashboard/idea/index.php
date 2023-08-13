<!DOCTYPE html>
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
?>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login page</title>
    <link type="text/css" href="css/bootstrap-rtl.min.css" rel="stylesheet">
    <link type="text/css" href="css/font-awesome.min.css" rel="stylesheet" />
    <style>
        <?php include 'CSS/style.css'; ?>
    </style>
</head>
<script src="js/validations.js"></script>

<body dir="rtl">
<div class="con tainer display">
    <div class="d-flex justify-content-center h-100">
        <div class="card">

            <div class="card-body">
                    <div class="input-group form-group">
                        <p class="titleboxstyle">User CPU Usage:</p>
                        <p class="textboxstyle"> <?php echo  fgets($userCpu) . "% &nbsp;&nbsp;&nbsp; CPU Idle: " . fgets($idleCpu) ; ?> </p>
                    </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">RAM Usage:</p>
                    <p class="textboxstyle"><?php echo "RAM Usage: " . fgets($availableMemory) . "KB / " . fgets($totalMemory) . "KB"; ?> </p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">System Load in 1 min:</p>
                    <p class="textboxstyle"><?php echo  fgets($systemLoad1min); ?> </p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">System Load in 5 min:</p>
                    <p class="textboxstyle"><?php echo  fgets($systemLoad5min); ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">System Load in 15 min:</p>
                    <p class="textboxstyle"><?php echo  fgets($systemLoad15min); ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Disk Usage:</p>
                    <p class="textboxstyle"><?php echo  fgets($diskUsed) . " / " . fgets($diskSize); ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Network:</p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Receive Traffic: </p>
                    <p class="textboxstyle"><?php echo   fgets($rxTraffic) . " " . fgets($rxTrafficUnit); ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Transmit Traffic: </p>
                    <p class="textboxstyle"><?php echo  fgets($txTraffic) . " " . fgets($txTrafficUnit); ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Top 10 processes by CPU usage:</p>
                    <p class="textboxstyle"><?php
                        while(!feof($processesByCpu))
                            echo fgets($processesByCpu) ?></p>
                </div>
                <div class="input-group form-group">
                    <p class="titleboxstyle">Top 10 processes by Memory usage: </p>
                    <p class="textboxstyle"><?php while(!feof($processesByMemory))
    echo fgets($processesByMemory) ; ?></p>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</body>
</html>
