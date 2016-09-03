# automatic virt-install kickstart
# needs templates.ks.cfg

# asks user for ks variables for network, hostname 
# this can automated in a variety of ways. 

echo ask netip
read netip
echo ask netgw
read netgw
echo ask nethostname
read nethostname
echo ask netdns
read netdns

date=`date +%F-%R-S` # date with YYYY-MM-DD-hh-mm-ss
ksname=$nethostname-$date

# hostname.fqdn-YYYY-MM-DD-hh-mm-ss.ks.cfg
echo Kickstart configuration file will appear as $ksname.ks.cfg
echo press enter
read

# writes out new kickstart cfg based on template + user input
cat template.ks.cfg | sed "s/netip/${netip}/g" | sed "s/netdns/${netdns}/g" | sed "s/nethostname/${nethostname}/g" | sed "s/netgw/${netgw}/g" > /var/www/html/inst/$ksname.ks.cfg
	
echo "virt-install -r 1024 --disk path=/var/lib/libvirt/images/$nethostname.img,size=16 -l http://10.0.0.11/inst -x ks=http://10.0.0.11/inst/$ksname.ks.cfg --name $nethostname"

echo "press CTRL+C if doesn't look right."
echo Else, press enter.
read

virt-install -r 1024 --disk path=/var/lib/libvirt/images/$nethostname.img,size=16 -l http://10.0.0.11/inst -x ks=http://10.0.0.11/inst/$ksname.ks.cfg --name $nethostname
