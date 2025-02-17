(cd ../stars_backend; uvicorn database_service:app --host 127.0.0.1 --port 5000 --reload 1> "backend_log.txt" 2> "backend_error_log.txt") &
(cd ../StarsApplication; uvicorn main:app --host 127.0.0.1 --port 8000 --reload 1> "app_log.txt" 2> "app_error_log.txt") &
(cd ../StarsFrontend/static; python3 -m http.server 3000 1> "frontend_log.txt" 2> "frontend_error_log.txt") &

echo "http://localhost:3000"

read -p "Press any key to quit (don't Ctrl + C!)... " -n1 -s

sudo lsof | grep -E ":8000|:5000|:3000" | 
    awk '{print $2}' |
    while read line ; do
      kill -9 "$line"
    done

echo  "Processes terminated succesfully!"