--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (245, 2018, 'Final', 743, 744, 4, 2);
INSERT INTO public.games VALUES (246, 2018, 'Third Place', 745, 746, 2, 0);
INSERT INTO public.games VALUES (247, 2018, 'Semi-Final', 744, 746, 2, 1);
INSERT INTO public.games VALUES (248, 2018, 'Semi-Final', 743, 745, 1, 0);
INSERT INTO public.games VALUES (249, 2018, 'Quarter-Final', 744, 747, 3, 2);
INSERT INTO public.games VALUES (250, 2018, 'Quarter-Final', 746, 748, 2, 0);
INSERT INTO public.games VALUES (251, 2018, 'Quarter-Final', 745, 749, 2, 1);
INSERT INTO public.games VALUES (252, 2018, 'Quarter-Final', 743, 750, 2, 0);
INSERT INTO public.games VALUES (253, 2018, 'Eighth-Final', 746, 751, 2, 1);
INSERT INTO public.games VALUES (254, 2018, 'Eighth-Final', 748, 752, 1, 0);
INSERT INTO public.games VALUES (255, 2018, 'Eighth-Final', 745, 753, 3, 2);
INSERT INTO public.games VALUES (256, 2018, 'Eighth-Final', 749, 754, 2, 0);
INSERT INTO public.games VALUES (257, 2018, 'Eighth-Final', 744, 755, 2, 1);
INSERT INTO public.games VALUES (258, 2018, 'Eighth-Final', 747, 756, 2, 1);
INSERT INTO public.games VALUES (259, 2018, 'Eighth-Final', 750, 757, 2, 1);
INSERT INTO public.games VALUES (260, 2018, 'Eighth-Final', 743, 758, 4, 3);
INSERT INTO public.games VALUES (261, 2014, 'Final', 759, 758, 1, 0);
INSERT INTO public.games VALUES (262, 2014, 'Third Place', 760, 749, 3, 0);
INSERT INTO public.games VALUES (263, 2014, 'Semi-Final', 758, 760, 1, 0);
INSERT INTO public.games VALUES (264, 2014, 'Semi-Final', 759, 749, 7, 1);
INSERT INTO public.games VALUES (265, 2014, 'Quarter-Final', 760, 761, 1, 0);
INSERT INTO public.games VALUES (266, 2014, 'Quarter-Final', 758, 745, 1, 0);
INSERT INTO public.games VALUES (267, 2014, 'Quarter-Final', 749, 751, 2, 1);
INSERT INTO public.games VALUES (268, 2014, 'Quarter-Final', 759, 743, 1, 0);
INSERT INTO public.games VALUES (269, 2014, 'Eighth-Final', 749, 762, 2, 1);
INSERT INTO public.games VALUES (270, 2014, 'Eighth-Final', 751, 750, 2, 0);
INSERT INTO public.games VALUES (271, 2014, 'Eighth-Final', 743, 763, 2, 0);
INSERT INTO public.games VALUES (272, 2014, 'Eighth-Final', 759, 764, 2, 1);
INSERT INTO public.games VALUES (273, 2014, 'Eighth-Final', 760, 754, 2, 1);
INSERT INTO public.games VALUES (274, 2014, 'Eighth-Final', 761, 765, 2, 1);
INSERT INTO public.games VALUES (275, 2014, 'Eighth-Final', 758, 752, 1, 0);
INSERT INTO public.games VALUES (276, 2014, 'Eighth-Final', 745, 766, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (743, 'France');
INSERT INTO public.teams VALUES (744, 'Croatia');
INSERT INTO public.teams VALUES (745, 'Belgium');
INSERT INTO public.teams VALUES (746, 'England');
INSERT INTO public.teams VALUES (747, 'Russia');
INSERT INTO public.teams VALUES (748, 'Sweden');
INSERT INTO public.teams VALUES (749, 'Brazil');
INSERT INTO public.teams VALUES (750, 'Uruguay');
INSERT INTO public.teams VALUES (751, 'Colombia');
INSERT INTO public.teams VALUES (752, 'Switzerland');
INSERT INTO public.teams VALUES (753, 'Japan');
INSERT INTO public.teams VALUES (754, 'Mexico');
INSERT INTO public.teams VALUES (755, 'Denmark');
INSERT INTO public.teams VALUES (756, 'Spain');
INSERT INTO public.teams VALUES (757, 'Portugal');
INSERT INTO public.teams VALUES (758, 'Argentina');
INSERT INTO public.teams VALUES (759, 'Germany');
INSERT INTO public.teams VALUES (760, 'Netherlands');
INSERT INTO public.teams VALUES (761, 'Costa Rica');
INSERT INTO public.teams VALUES (762, 'Chile');
INSERT INTO public.teams VALUES (763, 'Nigeria');
INSERT INTO public.teams VALUES (764, 'Algeria');
INSERT INTO public.teams VALUES (765, 'Greece');
INSERT INTO public.teams VALUES (766, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 276, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 766, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

