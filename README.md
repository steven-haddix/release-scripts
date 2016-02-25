#Steps

1. Create release branch for common-web
  + run create_release.sh and name the release in the format `month`_`weekNum`  
  
    Example:  
    
    ```
    ./create_release.sh http://gitlab/wms/common-web.git february_2
    ```
2. Create release branches for *each* project (ie. my, find, order, cso, careers, wendys-payment) 
  + run create_release_and_update_common-web.sh and name the release in the format `month`_`weekNum`
  + *NOTE* remember to do this for every project!
  
    Example:  
    
    ```
    ./create_release_and_update_common-web.sh http://gitlab/wms/common-web.git february_2
    ```
3. Build each project in Jenkins for `Test Deploy Pipeline` 
  + For each project, under gitlab/jenkins , click the Test Deploy Pipeline job and "Build with Parameters" 
  + *NOTE* remember to do this for every project!
  
    Example:  
    
    ```
    go to project (ex: http://gitlab/jenkins/job/Careers%20C.I.%20TEST%20Deploy%20Pipeline/)
    click Build with Parameters
    enter the release name (ex: february_2)
    ```
    

