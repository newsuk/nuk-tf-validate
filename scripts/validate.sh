#!/bin/bash          
   
listOfProviderFiles=/tmp/listofproviderfiles
echo "Finding All provider.tf Files..."
find . -type f -name provider.tf >> ${listOfProviderFiles}
echo "list of provider.tf files"
cat ${listOfProviderFiles}
home=$(pwd)
numberOfProviderFiles=$(cat ${listOfProviderFiles} | wc -l)
echo "${numberOfProviderFiles} provider files found"
if [[ ${numberOfProviderFiles} -ne 0 ]]
then
  providerFile=$(cat ${listOfProviderFiles} | head -1)
  providerDir=${providerFile%/provider.tf}
  cd ${providerDir}
  pwd
  terraform init -backend=false && \
  cd ${home} && \
  terraform validate
else
  echo "no provider.tf files found"
fi
