#!/bin/bash

# This script downloads the xml configuration from Palo Alto firewall and creates
# a csv file of the security rules in the config.
# You will need to generate an API key on the firewall (CAP fields are user-provided):
# https://FIREWALL/api/?type=keygen&user=USERNAME&password=PASSWORD
# Keep in mind that the key will have all the rights of the username that created
# it, so it's advisable to create a "Superuser(read-only)" login for this purpose,
# and generate the key with that user.

# Make this .sh file executable with chmod +x, and run it from directory where the xsl
# template is located.

# firewall name, for output file creation
fwname='officeFW'
# fwname='productionFW'
# fwname='labFW'

# date and time
dt=`date +"%Y%m%d%H%M"`

# firewall mgmt fqdn or IP
fwip='10.1.1.1' # Office firewall
# fwip='10.2.1.1' # Production firewall
# fwip='10.3.1.1' # Lab firewall

# key for api, generated as described above
key='LUFRPT1aBunchOfRandomCharactersCreatedByThePAsAPIKeyGeneratorT0' # Office firewall
# key='LUFRPT1AnotherBunchOfRandomCharactersCreatedByThePAsAPIKeyGeneratorT0' # Production firewall
# key='LUFRPT1YetAnotherBunchOfRandomCharactersCreatedByThePAsAPIKeyGeneratorT0' # Lab firewall

# The following commands create a heading line, then pull the firewall's configuration
# with curl, removing everything before and after the security tags. It strips out the
# member tags, so that all members in a rule end up in a single cell in the spreadsheet,
# then runs the xml through the xsl template, and writes it to a timestamped csv file.

echo 'name,source,destination,from,to,source-user,application,service,action,disabled,profile-setting,description' \
>> ${dt}-${fwname}.csv
echo `curl -k 'https://'${fwip}'/api/?type=export&category=configuration&key='${key}` \
| xmllint --format - | sed -n '/<security>/,/<\/security>/p' | sed 's/<member>//g' \
| sed 's/<\/member>//g' | xsltproc PASecTemplate.xsl - >> ${dt}-${fwname}.csv

echo "created file ${dt}-${fwname}.csv"

