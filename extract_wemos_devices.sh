# Extract from CASA items file on OpenHAB the WeMos Devices configured on it and put on a file
cat /opt/openhab/conf/items/casa.items | grep "cmnd/wemos_......" -o | grep "wemos_......" -o > wemos_devices.txt