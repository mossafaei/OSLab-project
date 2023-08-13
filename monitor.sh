get_system_load_variables() {
    
    local dir=/tmp/systemLoad/
    mkdir -p $dir
    touch $dir/1min
    touch $dir/5min
    touch $dir/15min

    local uptime=`uptime`
    system_load_1_min=`echo $uptime | grep -oP '[0-9]+\.[0-9]+' | sed -n '1p'`
    system_load_5_min=`echo $uptime | grep -oP '[0-9]+\.[0-9]+' | sed -n '2p'`
    system_load_15_min=`echo $uptime | grep -oP '[0-9]+\.[0-9]+' | sed -n '3p'`

    echo $system_load_1_min > $dir/1min
    echo $system_load_5_min > $dir/5min
    echo $system_load_15_min > $dir/15min
}

get_list_of_processes() {
    
    local dir=/tmp/listOfProcesses/
    mkdir -p $dir
    touch $dir/processesByCpu
    touch $dir/processesByMemory
    
    ps -aux --sort=-pcpu | head -n10 > $dir/processesByCpu
    ps -aux --sort=-pmem | head -n10 > $dir/processesByMemory

}

get_disk_variables() {

    local dir=/tmp/diskVariables
    mkdir -p $dir
    touch $dir/diskSize
    touch $dir/diskUsed
    touch $dir/diskAvailable
    touch $dir/diskUsePercentage

    local df=`df -h / | sed -n '2p'`

    disk_size=`echo $df | awk '{print $2}'`
    disk_used=`echo $df | awk '{print $3}'`
    disk_available=`echo $df | awk '{print $4}'`
    disk_use_percentage=`echo $df | awk '{print $5}'`

    echo $disk_size > $dir/diskSize
    echo $disk_used > $dir/diskUsed
    echo $disk_available > $dir/diskAvailable
    echo $disk_use_percentage > $dir/diskUsePercentage

}

get_network_variables() {
    
    local dir=/tmp/networkVariables
    mkdir -p $dir
    touch $dir/rxTraffic
    touch $dir/rxTrafficUnit
    touch $dir/txTraffic
    touch $dir/txTrafficUnit

    local vn=`vnstat -tr`
    
    rx_traffic=`echo $vn | awk '{print $16}'`
    rx_traffic_unit=`echo $vn | awk '{print $17}'`
    tx_traffic=`echo $vn | awk '{print $21}'`
    tx_traffic_unit=`echo $vn | awk '{print $22}'`

    echo $rx_traffic > $dir/rxTraffic
    echo $rx_traffic_unit > $dir/rxTrafficUnit
    echo $tx_traffic > $dir/txTraffic
    echo $tx_traffic_unit > $dir/txTrafficUnit

}

get_cpu_variables() {
    
    local dir=/tmp/cpuVariables/
    mkdir -p $dir
    touch $dir/numberOfCores
    touch $dir/userCpu
    touch $dir/systemCpu
    touch $dir/niceCpu
    touch $dir/idleCpu
    touch $dir/ioWaitCpu
    touch $dir/hardwareInterruptCpu
    touch $dir/softwareInterruptCpu
    touch $dir/stCpu

    number_of_cores=`lscpu | grep -E '^CPU\(' | awk '{print $2}'`
    
    local top=`top -b -n1 | sed -n '3p' | tr -d ' ' | sed 's/%Cpu(s)://'`
    user_cpu=`echo $top | cut -d, -f1 | sed 's/..$//'`        
    system_cpu=`echo $top | cut -d, -f2 | sed 's/..$//'`
    nice_cpu=`echo $top | cut -d, -f3 | sed 's/..$//'`
    idle_cpu=`echo $top | cut -d, -f4 | sed 's/..$//'`
    io_wait_cpu=`echo $top | cut -d, -f5 | sed 's/..$//'`
    hardware_interrupt_cpu=`echo $top | cut -d, -f6 | sed 's/..$//'`
    software_interrupt_cpu=`echo $top | cut -d, -f7 | sed 's/..$//'`
    st_cpu=`echo $top | cut -d, -f8 | sed 's/st//'`

    echo $number_of_cores > $dir/numberOfCores
    echo $user_cpu > $dir/userCpu
    echo $system_cpu > $dir/systemCpu
    echo $nice_cpu > $dir/niceCpu
    echo $idle_cpu > $dir/idleCpu
    echo $io_wait_cpu > $dir/ioWaitCpu
    echo $hardware_interrupt_cpu > $dir/hardwareInterruptCpu
    echo $software_interrupt_cpu > $dir/softwareInterruptCpu
    echo $st_cpu > $dir/stCpu
}

get_memory_variables() {
    
    local dir=/tmp/memoryVariables
    mkdir -p $dir
    touch $dir/totalMemory
    touch $dir/usedMemory
    touch $dir/freeMemory
    touch $dir/sharedMemory
    touch $dir/cacheMemory
    touch $dir/availableMemory

    local free=`free | sed -n '2p'`
    total_memory=`echo $free | awk '{ print $2 }'`
    used_memory=`echo $free | awk '{ print $3 }'`
    free_memory=`echo $free | awk '{ print $4 }'`
    shared_memory=`echo $free | awk '{ print $5 }'`
    cache_memory=`echo $free | awk '{ print $6 }'`
    available_memory=`echo $free | awk '{ print $7 }'`

    echo $total_memory > $dir/totalMemory
    echo $used_memory > $dir/usedMemory
    echo $free_memory > $dir/freeMemory
    echo $shared_memory > $dir/sharedMemory
    echo $cache_memory > $dir/cacheMemory
    echo $available_memory > $dir/availableMemory
   
}

call_triggers(){
    
    local dir=Triggers/

    bash ./$dir/highSystemLoad.sh $number_of_cores $system_load_1_min $system_load_5_min $system_load_15_min
    bash ./$dir/highCpuUsage.sh $number_of_cores $user_cpu
    bash ./$dir/highMemoryUsage.sh $total_memory $available_memory
    bash ./$dir/highDiskUsage.sh $disk_use_percentage
    
}



get_system_load_variables
get_list_of_processes
get_disk_variables
get_network_variables
get_cpu_variables
get_memory_variables

call_triggers

