#Update OpenHAB Docker image and then re-create openhab container                                           
                                                                                                            
                                                                                                            
#Update docker image, stop and  destroy existing container                                                  
docker pull openhab/openhab:2.2.0-snapshot-amd64                                                            
docker stop openhab-test                                                                                    
docker rm openhab-test                                                                                      
                                                                                                            
#Clean some files and set user owner                                                                        
rm -rf /opt/openhab-test/userdata/cache/*                                                                   
rm -rf /opt/openhab-test/userdata/tmp/*                                                                     
rm -rf /opt/openhab/userdata/tmp/.*                                                                         
rm /opt/openhab/userdata/karaf.pid                                                                          
rm /opt/openhab/userdata/lock                                                                               
chown -R openhab:openhab /opt/openhab-test                                                                  
                                                                                                            
#Re-Create Openhab container using the new image                                                            
docker run --name=openhab-test --net=host \                                                                 
-v /etc/localtime:/etc/localtime:ro \                                                                       
-v /etc/timezone:/etc/timezone:ro \                                                                         
-v /opt/openhab-test/conf:/openhab/conf \                                                                   
-v /opt/openhab-test/userdata:/openhab/userdata \                                                           
-v /opt/openhab-test/addons:/openhab/addons \                                                               
-e USER_ID=998 \                                                                                            
-e OPENHAB_HTTP_PORT=8089 \                                                                                 
-e OPENHAB_HTTPS_PORT=4444  \                                                                               
-e EXTRA_JAVA_OPTS="-Djava.net.preferIPv4Stack=true" \                                                      
-d \                                                                                                        
openhab/openhab:2.2.0-snapshot-amd64                                                                        
                                                                                                            
#Copy branding files...                                                                                     
docker exec openhab-test cp -av /openhab/userdata.dist/etc/branding.properties /openhab/userdata/etc/       
docker exec openhab-test cp -av /openhab/userdata.dist/etc/branding-ssh.properties /openhab/userdata/etc/   