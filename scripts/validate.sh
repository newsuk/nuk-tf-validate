#!/bin/bash          
   
listOfProviderFiles=/tmp/listofproviderfiles
echo "Finding All provider.tf Files..."
find . -type f -name provider.tf >> ${listOfProviderFiles}
echo "list of provider.tf files"
cat ${listOfProviderFiles}
home=$(pwd)
numberOfProviderFiles=$(cat ${listOfProviderFiles} | wc -l)
if [[ ${numberOfProviderFiles} -ne 0 ]]
then
  cat ${listOfProviderFiles} | while read providerFile
  do
  providerDir=${providerFile%/provider.tf}
  cd ${providerDir}
  pwd
  terraform init -backend=false && \
  terraform validate
  cd ${home}
 done
else
  echo "no provider.tf files found"
fi
