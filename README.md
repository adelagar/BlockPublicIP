# BlockPublicIP

Some organizations may want to deploy a resource in Azure that is not accessible from the general internet.
The following script applies an Azure policy to block the creation of a Public IP resource within the specified resource group
and avoid a potential back door.

General recommendation is to only have one specified method of gaining remote access into an Azure virtual network (VNET) such as a JUMP Server that is listening for either SSH or RDP with some type of multifactor authentication enabled, a VPN server, or a general Site to Site IPSEC tunnel connected to on-premises.
