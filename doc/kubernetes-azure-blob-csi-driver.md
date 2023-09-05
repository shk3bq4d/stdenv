* https://github.com/kubernetes-sigs/blob-csi-driver
* https://github.com/kubernetes-sigs/blob-csi-driver/releases
* https://github.com/kubernetes-sigs/blob-csi-driver/tree/master/charts


```sh
kubectl get csidriver blob.csi.azure.com -o yaml
```


https://github.com/Azure/azure-storage-fuse/issues/866 # Can't access file in subdir ("No such file or directory" when accessing)
block-list-on-mount-sec
cancel-list-on-mount-seconds
https://github.com/Azure/azure-storage-fuse/issues/1078#issuecomment-1459437517
When you mount any file-system kernel by default tries to list the root,
sometimes it tries to do this multiple times. There were customers who had
issue with this as they had a large number of files. If kernel tries to do
implicit listing multiple times customer will get charged for those
listBlob calls. So, we provided this option so disable directory listing
for initial few seconds after mounting. As you have configured it to 10,
listing api will not work for 10 seconds after mount and post that it will
return back to normal mode. If you are concerned with this cost too you
can keep the option on and try listing after 10-15 seconds and everything
shall work fine.
