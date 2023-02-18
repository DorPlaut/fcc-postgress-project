#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

# main menu
MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
    else
  echo -e "\nWelcome to My Salon, how can I help you?:"
  fi
  # get available services
  SERVICES=$($PSQL "SELECT * FROM services ORDER BY service_id;")

  # show services
  echo "$SERVICES" | while read SERVICE_ID BAR NAME; do
    echo "$SERVICE_ID) $NAME"
  done
# }

# # select service
# SELECT_SERVICE() {
  read SERVICE_ID_SELECTED

  # if input is not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
    # send back to main menu
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi

  # get selected service
  SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED';")

  # if service doesn't exist
  if [[ -z $SERVICE ]]; then
    # send back to main menu
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi

  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")


  # if customer doesn't exist
  if [[ -z $NAME ]]; then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer
INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
  else
    CUSTOMER_NAME=$NAME
  fi

  echo -e "\nWhat time would you like your$SERVICE appointment,$CUSTOMER_NAME?"
  read SERVICE_TIME
# get customer ID

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  # insert new appointment
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME');")
  echo -e "\nI have put you down for a$SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."

}

# run the script
MAIN_MENU