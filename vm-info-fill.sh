#/bin/bash
openstack server list -f value -c ID --all-projects > servers-all.uuid
echo VM_ID"|"NAME"|"INSTANCE"|"HOST"|"STATE"|"CREATED"|"UPDATED"|"FLAVOR"|"IMAGE"|"NETS"|"PROJECT"|"VOLUMES > vm_info.unl
while read VM_ID
do
 	#echo $vm_id
        NAME=`openstack server show -f value -c name $VM_ID`
	INSTANCE=`openstack server show -f value -c "OS-EXT-SRV-ATTR:instance_name" $VM_ID`
        HOST=`openstack server show -f value -c "OS-EXT-SRV-ATTR:hypervisor_hostname" $VM_ID`
        STATE=`openstack server show -f value -c "OS-EXT-STS:vm_state" $VM_ID`
        CREATED=`openstack server show -f value -c created $VM_ID`
        UPDATED=`openstack server show -f value -c updated $VM_ID`
        FLAVOR=`openstack server show -f value -c flavor $VM_ID`
        IMAGE=`openstack server show -f value -c image $VM_ID`
        NETS=`openstack server show -f value -c addresses $VM_ID`
        PROJECT=`openstack server show -f value -c project_id $VM_ID`
        VOLUMES=`openstack server show -f value -c "os-extended-volumes:volumes_attached" $VM_ID`
	echo $VM_ID"|"$NAME"|"$INSTANCE"|"$HOST"|"$STATE"|"$CREATED"|"$UPDATED"|"$FLAVOR"|"$IMAGE"|"$NETS"|"$PROJECT"|"$VOLUMES >> vm_info.unl
done < servers-all.uuid
echo "All servers export complete!"
