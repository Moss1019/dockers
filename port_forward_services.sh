#! /bin/bash

./port_forward.sh mosson postgres 5432 5431 &

./port_forward.sh mosson artemis 8161 8160 &

./port_forward.sh mosson kibana 5601 5600 &

./port_forward.sh mosson vsftpd-pub 20 2001 &
./port_forward.sh mosson vsftpd-pub 21 2101 &
./port_forward.sh mosson vsftpd-pub 22 2201 &
./port_forward.sh mosson vsftpd-pub 4565 4565 &
./port_forward.sh mosson vsftpd-pub 4566 4566 &
./port_forward.sh mosson vsftpd-pub 4567 4567 &
./port_forward.sh mosson vsftpd-pub 4568 4568 &
./port_forward.sh mosson vsftpd-pub 4569 4569 &
./port_forward.sh mosson vsftpd-pub 4570 4570 &

./port_forward.sh mosson vsftpd-pri 20 2000 &
./port_forward.sh mosson vsftpd-pri 21 2100 &
./port_forward.sh mosson vsftpd-pri 22 2200 &
./port_forward.sh mosson vsftpd-pri 4559 4559 &
./port_forward.sh mosson vsftpd-pri 4560 4560 &
./port_forward.sh mosson vsftpd-pri 4561 4561 &
./port_forward.sh mosson vsftpd-pri 4562 4562 &
./port_forward.sh mosson vsftpd-pri 4563 4563 &
./port_forward.sh mosson vsftpd-pri 4564 4564 &

./port_forward.sh mosson mosson-logging-sink 6001 6101 &

./port_forward.sh mosson product-data-api 7000 7100 &

./port_forward.sh mosson seller01 11000 12000 &

echo "Press enter to close"
read ans

pids=$(ps -aux | grep "kubectl port-forward" | grep -v "grep" | awk '{print $2}')

for p in ${pids[@]}
do
    process=$(ps -aux | grep "kubectl port-forward" | grep $p)
    echo "killing $process"
    kill "$p"
done
