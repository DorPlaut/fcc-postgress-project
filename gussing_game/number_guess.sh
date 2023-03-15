#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"

# greeting
echo "Enter your username:"
read USERNAME

# look for user
EXISTING_USER=$($PSQL "select username from users where username='$USERNAME';")
 # if user doesn't exist
if [[ -z $EXISTING_USER ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
# insert new user
  NEW_USER=$PSQL "insert into users (username) values ('$USERNAME')"  
# if user does exist
else
  USER_ID=$($PSQL "select user_id from users where username='$USERNAME';")
  GAMES_COUNT=$($PSQL "select count(*) from games where user_id='$USER_ID';")
  BEST_GAME_GUESS_COUNT=$($PSQL "select coalesce(min(games), -1) from won_user_games where user_id=$USER_ID;")
# greet user
  echo "Welcome back, $USERNAME! You have played $GAMES_COUNT games, and your best game took $BEST_GAME_GUESS_COUNT guesses."
fi

# insert a new game for the user
INSERT_GAME=$($PSQL "INSERT INTO games (user_id) SELECT user_id FROM users WHERE username = '$USERNAME' RETURNING game_id;")
# set data for game
# get the random num to guess
RANDOM_NUM=$(( ( RANDOM % 1000 ) + 1 ))
# get the user id
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")
# get the game id
GAME_ID=$($PSQL "SELECT game_id FROM games WHERE user_id = '$USER_ID' ORDER BY game_id DESC LIMIT 1;")

# LET'S PLAY

# game function
function GAME() {
  # start game message
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nGuess the secret number between 1 and 1000:"
  fi 
  # read user guess
  read USER_GUESS
  # if not number
  if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]; then
    GAME "That is not an integer, guess again:"
  fi

  # check if guess is correct
  if [ "$USER_GUESS" != "$RANDOM_NUM" ]; then
    # add to the guesses column
    COUNT=$($PSQL "SELECT guesses FROM games WHERE game_id = '$GAME_ID';")
    NEW_COUNT=$((COUNT + 1))
    INCREMENT_GUESS=$($PSQL "UPDATE games SET guesses = $NEW_COUNT WHERE user_id = '$USER_ID' AND game_id = '$GAME_ID';")
    # if guess is lower than number
    if [ "$USER_GUESS" -lt "$RANDOM_NUM" ]; then
      GAME "It's higher than that, guess again:"
    # if guess is higher than number
    else
      GAME "It's lower than that, guess again:"
    fi
  else
    GUESSES=$($PSQL "SELECT guesses FROM games WHERE user_id = '$USER_ID' AND game_id = '$GAME_ID';")
    echo -e "\nYou guessed it in $GUESSES tries. The secret number was $RANDOM_NUM. Nice job!"
  fi
}

# start the game
GAME
