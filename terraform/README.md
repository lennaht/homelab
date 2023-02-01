# Creating a cloud-init template for cloning:
Credits to [Techno Tim](https://docs.technotim.live/posts/cloud-init-cloud-image/).

Choose your [Ubuntu Cloud Image](https://cloud-images.ubuntu.com/)

Download Ubuntu (replace with the url of the one you chose from above)

Always replace 8000 with your own template id and local-lvm with your storage name.

```
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
```

Create a new virtual machine
```
qm create 8000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
```

Import the downloaded Ubuntu disk to local-lvm storage
```
qm importdisk 8000 focal-server-cloudimg-amd64.img local-lvm
```

Attach the new disk to the vm as a scsi drive on the scsi controller
```
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
```

Add cloud init drive
```
qm set 8000 --ide2 local-lvm:cloudinit
```

Make the cloud init drive bootable and restrict BIOS to boot from disk only
```
qm set 8000 --boot c --bootdisk scsi0
```

Add serial console
```
qm set 8000 --serial0 socket --vga serial0
```

**DO NOT START YOUR VM**

Now, configure hardware and cloud init, then create a template and clone. If you want to expand your hard drive you can on this base image before creating a template or after you clone a new machine. I prefer to expand the hard drive after I clone a new machine based on need.

Create template.
```
qm template 8000
```

Clone template.
```
qm clone 8000 135 --name yoshi --full
```
135 is the new id.
