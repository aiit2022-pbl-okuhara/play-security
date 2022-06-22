--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 14.4

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
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(128) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid NOT NULL,
    display_id integer NOT NULL,
    name character varying(128) NOT NULL,
    report_send_emails character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name character varying(128) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: scenario_quiz_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scenario_quiz_options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    scenario_quiz_id uuid NOT NULL,
    answer character varying(255) NOT NULL,
    score integer NOT NULL,
    next_scenario_quiz_id uuid,
    next_status integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.scenario_quiz_options OWNER TO postgres;

--
-- Name: scenario_quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scenario_quizzes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    scenario_id uuid NOT NULL,
    question text NOT NULL,
    success_message text NOT NULL,
    failure_message text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.scenario_quizzes OWNER TO postgres;

--
-- Name: scenario_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scenario_tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tag_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.scenario_tags OWNER TO postgres;

--
-- Name: scenarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scenarios (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    role_id uuid NOT NULL,
    scenario_title character varying(255) NOT NULL,
    scenario_overview text NOT NULL,
    scenario_description text NOT NULL,
    total_score integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.scenarios OWNER TO postgres;

--
-- Name: schema_migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migration (
    version character varying(14) NOT NULL
);


ALTER TABLE public.schema_migration OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(128) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: user_authentication_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_authentication_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_authentication_logs OWNER TO postgres;

--
-- Name: user_organization_belonging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_organization_belonging (
    user_id uuid NOT NULL,
    organization_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_organization_belonging OWNER TO postgres;

--
-- Name: user_scenario_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_scenario_histories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    scenario_id uuid NOT NULL,
    total_score integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_scenario_histories OWNER TO postgres;

--
-- Name: user_scenario_quiz_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_scenario_quiz_histories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_scenario_history_id uuid NOT NULL,
    user_id uuid NOT NULL,
    scenario_id uuid NOT NULL,
    scenario_quiz_id uuid NOT NULL,
    scenario_quiz_option_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_scenario_quiz_histories OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    last_name character varying(128) NOT NULL,
    first_name character varying(128) NOT NULL,
    last_name_kana character varying(128) NOT NULL,
    first_name_kana character varying(128) NOT NULL,
    nickname character varying(20) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: scenario_quiz_options scenario_quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_quiz_options
    ADD CONSTRAINT scenario_quiz_options_pkey PRIMARY KEY (id);


--
-- Name: scenario_quizzes scenario_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_quizzes
    ADD CONSTRAINT scenario_quizzes_pkey PRIMARY KEY (id);


--
-- Name: scenario_tags scenario_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_tags
    ADD CONSTRAINT scenario_tags_pkey PRIMARY KEY (id);


--
-- Name: scenarios scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenarios
    ADD CONSTRAINT scenarios_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_authentication_logs user_authentication_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_authentication_logs
    ADD CONSTRAINT user_authentication_logs_pkey PRIMARY KEY (id);


--
-- Name: user_scenario_histories user_scenario_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_histories
    ADD CONSTRAINT user_scenario_histories_pkey PRIMARY KEY (id);


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: organizations_display_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX organizations_display_id_idx ON public.organizations USING btree (display_id);


--
-- Name: schema_migration_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX schema_migration_version_idx ON public.schema_migration USING btree (version);


--
-- Name: organizations organizations_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: roles roles_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: scenario_quiz_options scenario_quiz_options_next_scenario_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_quiz_options
    ADD CONSTRAINT scenario_quiz_options_next_scenario_quiz_id_fkey FOREIGN KEY (next_scenario_quiz_id) REFERENCES public.scenario_quizzes(id) ON DELETE CASCADE;


--
-- Name: scenario_quiz_options scenario_quiz_options_scenario_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_quiz_options
    ADD CONSTRAINT scenario_quiz_options_scenario_quiz_id_fkey FOREIGN KEY (scenario_quiz_id) REFERENCES public.scenario_quizzes(id) ON DELETE CASCADE;


--
-- Name: scenario_quizzes scenario_quizzes_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_quizzes
    ADD CONSTRAINT scenario_quizzes_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES public.scenarios(id) ON DELETE CASCADE;


--
-- Name: scenario_tags scenario_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenario_tags
    ADD CONSTRAINT scenario_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: scenarios scenarios_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenarios
    ADD CONSTRAINT scenarios_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: scenarios scenarios_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenarios
    ADD CONSTRAINT scenarios_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_authentication_logs user_authentication_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_authentication_logs
    ADD CONSTRAINT user_authentication_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_organization_belonging user_organization_belonging_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_organization_belonging
    ADD CONSTRAINT user_organization_belonging_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: user_organization_belonging user_organization_belonging_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_organization_belonging
    ADD CONSTRAINT user_organization_belonging_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_scenario_histories user_scenario_histories_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_histories
    ADD CONSTRAINT user_scenario_histories_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES public.scenarios(id) ON DELETE CASCADE;


--
-- Name: user_scenario_histories user_scenario_histories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_histories
    ADD CONSTRAINT user_scenario_histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES public.scenarios(id) ON DELETE CASCADE;


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_scenario_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_scenario_quiz_id_fkey FOREIGN KEY (scenario_quiz_id) REFERENCES public.scenario_quizzes(id) ON DELETE CASCADE;


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_scenario_quiz_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_scenario_quiz_option_id_fkey FOREIGN KEY (scenario_quiz_option_id) REFERENCES public.scenario_quiz_options(id) ON DELETE CASCADE;


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_scenario_quiz_histories user_scenario_quiz_histories_user_scenario_history_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scenario_quiz_histories
    ADD CONSTRAINT user_scenario_quiz_histories_user_scenario_history_id_fkey FOREIGN KEY (user_scenario_history_id) REFERENCES public.user_scenario_histories(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

