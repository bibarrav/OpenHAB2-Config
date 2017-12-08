#Update OpenHAB Docker image and then re-create openhab container                                       
                                                                                                        
#Update docker image, stop and  destroy existing container                                              
#docker pull openhab/openhab:2.1.0-amd64                                                                
docker stop openhab                                                                                     
docker rm openhab                                                                                       
                                                                                                        
#Clean some files and set user owner                                                                    
rm -rf /opt/openhab/userdata/cache/*                                                                    
rm -rf /opt/openhab/userdata/tmp/*                                                                      
rm -rf /opt/openhab/userdata/tmp/.*                                                                     
rm /opt/openhab/userdata/karaf.pid                                                                      
rm /opt/openhab/userdata/lock                                                                           
chown -R openhab:openhab /opt/openhab                                                                   
                                                                                                        
#Re-Create Openhab container using the new image                                                        
docker run --name=openhab --net=host \                                                                  
-v /etc/localtime:/etc/localtime:ro \                                                                   
-v /etc/timezone:/etc/timezone:ro \                                                                     
-v /opt/openhab/conf:/openhab/conf \                                                                    
-v /opt/openhab/userdata:/openhab/userdata \                                                            
-v /opt/openhab/addons:/openhab/addons \                                                                
-e USER_ID=998 \                                                                                        
-e OPENHAB_HTTP_PORT=8088 \                                                                             
-e OPENHAB_HTTPS_PORT=4443  \                                                                           
-e EXTRA_JAVA_OPTS="-Djava.net.preferIPv4Stack=true" \                                                  
--restart=always -d \                                                                                   
openhab/openhab:2.2.0-snapshot-amd64-stable                                                             
                                                                                                        
#Copy branding files...                                                                                 
docker exec openhab cp -av /openhab/userdata.dist/etc/branding.properties /openhab/userdata/etc/        
docker exec openhab cp -av /openhab/userdata.dist/etc/branding-ssh.properties /openhab/userdata/etc/    