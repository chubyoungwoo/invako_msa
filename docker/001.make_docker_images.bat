@echo off
rem 지역변수 선언 시작
SETLOCAL
cd ../
SET project_dir=%cd%
echo %project_dir%

rem 1. discovery 도커 이미지 생성
cd %project_dir%/backend/invako/cloud/discovery
docker build -t discovery:1.0 -f ./Dockerfile .

rem 2. config 도커 이미지 생성
cd %project_dir%/backend/invako/cloud/config
docker build -t config:1.0 -f ./Dockerfile .

rem 3. apigateway 도커 이미지 생성
cd %project_dir%/backend/invako/cloud/apigateway
docker build -t apigateway:1.0 -f ./Dockerfile .

rem 4. user-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/user-service
docker build -t user-service:1.0 -f ./Dockerfile .

rem 5. portal-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/portal-service
docker build -t portal-service:1.0 -f ./Dockerfile .

rem 6. board-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/board-service
docker build -t board-service:1.0 -f ./Dockerfile .

rem 7. reserve-check-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/reserve-check-service
docker build -t reserve-check-service:1.0 -f ./Dockerfile .

rem 8. reserve-item-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/reserve-item-service
docker build -t reserve-item-service:1.0 -f ./Dockerfile .

rem 9. reserve-request-service 도커 이미지 생성
cd %project_dir%/backend/invako/service/reserve-request-service
docker build -t reserve-request-service:1.0 -f ./Dockerfile .


rem 10. frontend admin 도커 이미지 생성
cd %project_dir%/frontend/admin
docker build -t frontend-admin:1.0 -f ./Dockerfile .

rem 11. frontend portal 도커 이미지 생성
cd %project_dir%/frontend/portal
docker build -t frontend-portal:1.0 -f ./Dockerfile .

ENDLOCAL

rem 지역변수 끝