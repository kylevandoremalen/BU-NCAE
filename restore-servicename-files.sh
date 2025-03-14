#!/bin/bash
# Kyle Vandoremalen - March 2025
# Copies backup tarball back to service server and restores files or directories
# Edit to match your service/server variables

USER="kyle"
SERVICE_SERVER="rocky1"
COPY_TO_PATH="/tmp"
TAR_TO_RESTORE="/backups/apache/apache_service_backup.tar.gz"
NEW_TAR_NAME="apache_service_backup.tar.gz"

# Copy the tar file to the service server in /tmp

echo "Copying tar file back over"

rsync -av -e "ssh -i /root/restore_key" "$TAR_TO_RESTORE" "$USER@$SERVICE_SERVER:$COPY_TO_PATH/$NEW_TAR_NAME"

# Extract on the service server 

echo "Running extraction"

ssh -i /root/restore_key "$USER@$SERVICE_SERVER" "sudo tar --overwrite -xzf $COPY_TO_PATH/$NEW_TAR_NAME -C /"

echo ""
echo "File restore complete!"
echo "Services may need a restart to apply changes"
