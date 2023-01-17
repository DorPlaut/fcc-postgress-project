#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Script to insert data from games.csv into worldcup database
PSQL="psql -X --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"
echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

# add team names
  # insert winner
  if [[ $WINNER != "winner" ]]
  then
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # # if not found
    if [[ -z $TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_NAME == "INSERT 0 1" ]]
      then
        echo Inserted into majors, $WINNER
      fi
    fi
  fi

  # insert opponent
  if [[ $OPPONENT != "opponent" ]]
  then
  echo $OPPONENT
    # get opponent_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # # if not found
    if [[ -z $TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_NAME == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
    fi
  fi


# ADD GAMES
  if [[ $YEAR != "year" ]]
  then
  # get relevant id's
   WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
   OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
   echo $WINNER_ID $ROUND $OPPONENT_ID
      # insert teams and games
      INSERT_GAME_NAME=$($PSQL "INSERT INTO games( year, round, winner_id, opponent_id, winner_goals, opponent_goals  ) VALUES( $YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS )")
      if [[ $INSERT_GAME_NAME == "INSERT 0 1" ]]
      then
        echo Inserted into games
      fi   
  fi
done