# Azure Private DNS Resolver Prototype

#### From Azure Hub VNet (bep.hhs.gov)

Login to a VM in the Azure Hub VNET (Hostname: hubvmone):

DNS lookup for a VM in the Hub VNet 

```$nslookup hub-vmone.bep.hhs.gov```

DNS lookup for a VM in the Spoke  VNet 

```$nslookup spoke-app-vmone.bep.hhs.gov```

DNS lookup for a on-premise VM 

```$nslookup vmone.onpremise.hhs.gov ```

DNS lookup for a Azure Storage Table in the Spoke VNet 
```$nslookup hhscscbepffcfoprodstor.table.core.windows.net```

#### From Azure Spoke VNet (bep.hhs.gov)

Login to a VM in the Azure Spoke VNET (Hostname: spoke-app-vmone):

DNS lookup for a VM in the Hub VNet 

```$nslookup hub-vmone.bep.hhs.gov```

DNS lookup for a VM in the Spoke  VNet 

```$nslookup spoke-app-vmone.bep.hhs.gov```

DNS lookup for a on-premise VM 

```$nslookup vmone.onpremise.hhs.gov ```

DNS lookup for a Azure Storage Table in the Spoke VNet 
```$nslookup hhscscbepffcfoprodstor.table.core.windows.net```

#### From On-Premise VNet (onpremise.hhs.gov)

Login to a VM in the on-premise network (Hostname: onpremise-vmone):

DNS lookup for a on-premise VM 

```$nslookup vmone.onpremise.hhs.gov ```

DNS lookup for a VM in the Hub VNet 

```$nslookup hub-vmone.bep.hhs.gov```

DNS lookup for a VM in the Spoke VNet 

```$nslookup spoke-app-vmone.bep.hhs.gov```

DNS lookup for a Azure Storage Table in the Spoke VNet 
```$nslookup hhscscbepffcfoprodstor.table.core.windows.net```