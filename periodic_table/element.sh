#!/bin/bash

PSQL="psql -X psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

find_element() {
  local ELEMENT
  # find the element
  # if input is num
  if [[ $1 =~ ^[0-9]+$ ]]; then
    ELEMENT=$($PSQL "SELECT * FROM elements
    INNER JOIN properties ON elements.atomic_number = properties.atomic_number
    INNER JOIN types ON properties.type_id = types.type_id
    WHERE elements.atomic_number = $1;")
  # if input is up to 2 digit string
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]; then
    ELEMENT=$($PSQL "SELECT * FROM elements
    INNER JOIN properties ON elements.atomic_number = properties.atomic_number
    INNER JOIN types ON properties.type_id = types.type_id
    WHERE elements.symbol = '$1';")
  # if input is string that longer then 2 digits
  elif [[ $1 =~ ^[a-zA-Z]{3,}$ ]]; then
    ELEMENT=$($PSQL "SELECT * FROM elements
    INNER JOIN properties ON elements.atomic_number = properties.atomic_number
    INNER JOIN types ON properties.type_id = types.type_id
    WHERE elements.name = '$1';")
  fi
  echo "$ELEMENT"
}

# if there are arguments
if [[ $1 ]]
then
  ELEMENT=$(find_element $1)
  # if element dossent exist
  if [[ -z $ELEMENT ]]; then
    echo "I could not find that element in the database."
  else
    # rephrase element data
    echo "$ELEMENT" | while read ATOMIC_NUM BAR SYMBOL BAR NAME BAR NUM BAR MASS BAR MELTING BAR BOILING BAR TYPE_ID BAR ID BAR TYPE; do
        # send result
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
  fi
# if theres no argument input
else
  echo "Please provide an element as an argument."
fi