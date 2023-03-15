#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"

# greeting
echo "Enter your username:"
read USER_NAME

# look for user
USER=$($PSQL "SELECT * FROM users WHERE username = '$USER_NAME';")
# if user doesn't exist
if [[ -z $USER ]]; then
  # greet user
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  # insert new user
  INSERT_CUSTOMER=$($PSQL "INSERT INTO users (username) VALUES ('$USER_NAME');")
else
  # if user does exist
  # get user past games details
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) AS num_games FROM games INNER JOIN users ON games.user_id = users.user_id WHERE users.username = '$USER_NAME';")
  BEST_SCORE=$($PSQL "SELECT guesses FROM games INNER JOIN users ON games.user_id = users.user_id WHERE users.username = '$USER_NAME' ORDER BY guesses ASC LIMIT 1;")
  # greet user
  echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_SCORE guesses."
fi

# insert a new game for the user
INSERT_GAME=$($PSQL "INSERT INTO games (user_id) SELECT user_id FROM users WHERE username = '$USER_NAME' RETURNING game_id;")
# set data for game
# get the random num to guess
RANDOM_NUM=$(( ( RANDOM % 1000 ) + 1 ))
# get the user id
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USER_NAME';")
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


# 
# 
# 

#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"

# greeting
read -p "Enter your username: " USER_NAME



# validate username length
if [ ${#USER_NAME} -gt 22 ]; then
  echo "Error: username must be 22 characters or less."
  exit 1
fi


# look for user
USER=$($PSQL "SELECT * FROM users WHERE username = '$USER_NAME';")
# if user doesn't exist
if [[ -z $USER ]]; then
  # greet user
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  # insert new user
  INSERT_CUSTOMER=$($PSQL "INSERT INTO users (username) VALUES ('$USER_NAME');")
else
  # if user does exist
  # get user past games details
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) AS num_games FROM games INNER JOIN users ON games.user_id = users.user_id WHERE users.username = '$USER_NAME';")
  BEST_SCORE=$($PSQL "SELECT guesses FROM games INNER JOIN users ON games.user_id = users.user_id WHERE users.username = '$USER_NAME' ORDER BY guesses ASC LIMIT 1;")
  # greet user
  echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_SCORE guesses."
fi

# insert a new game for the user
INSERT_GAME=$($PSQL "INSERT INTO games (user_id) SELECT user_id FROM users WHERE username = '$USER_NAME' RETURNING game_id;")
# set data for game
# get the random num to guess
RANDOM_NUM=$(( ( RANDOM % 1000 ) + 1 ))
# get the user id
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USER_NAME';")
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




# 
# 
# 




SELECT *
FROM users
JOIN games ON users.user_id = games.user_id;


#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"

$PSQL "
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(22) NOT NULL
);
"
$PSQL "
CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(user_id),
  guesses INTEGER DEFAULT 0
);
"

