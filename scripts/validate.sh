#!/bin/bash          
   
listOfProviderFiles=/tmp/listofproviderfiles
tfFileList=/tmp/tffilelist
tfDirListtmp=/tmp/tfDirListtmp
tfDirList=/tmp/tfDirList
home=$(pwd)
echo "Finding All provider.tf Files .."
find . -type f -name provider.tf >> ${listOfProviderFiles}
echo "list of provider.tf files .."
cat ${listOfProviderFiles}
numberOfProviderFiles=$(cat ${listOfProviderFiles} | wc -l)
echo "${numberOfProviderFiles} provider files found"
if [[ ${numberOfProviderFiles} -ne 0 ]]
then
    providerFile=$(cat ${listOfProviderFiles} | head -1)
    providerDir=${providerFile%/provider.tf}
    cd ${providerDir}
    pwd
    terraform init -backend=false
    if [[ $? -ne 0 ]]
    then
        echo "error: could not initialise repo .. exiting" && exit 255
    else
        echo "Finding all .tf files .."
        cd ${home}
        find . -type f -name '*.tf' >> ${tfFileList}
        echo "generating list of directories containing .tf files .."
        cat ${tfFileList} | while read absolutePath
        do
            echo ${absolutePath%/*} >> ${tfDirListtmp}
        done
        echo "the following directories containing terraform will be validated .."
        cat ${tfDirListtmp} | sort | uniq >> ${tfDirList}
        cat ${tfDirList} ; echo ""
        cat ${tfDirList} ; while read dirContainingTf
        do
            echo "validating directory .. ${dirContainingTf}"
            cd ${dirContainingTf}
            terraform validate
            cd {home}
        done
    fi
else
  echo "no provider.tf files found"
fi
