--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_role AS ENUM (
    'viewer',
    'author',
    'editor',
    'admin',
    'super_admin',
    'staff'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE assignments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    image_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assignments_id_seq OWNED BY assignments.id;


--
-- Name: audits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audits (
    id integer NOT NULL,
    auditable_id integer NOT NULL,
    auditable_type character varying NOT NULL,
    associated_id integer NOT NULL,
    associated_type character varying NOT NULL,
    user_id integer,
    user_type character varying,
    username character varying,
    action character varying,
    audited_changes text,
    version integer DEFAULT 0,
    comment character varying,
    remote_address character varying,
    request_uuid character varying,
    created_at timestamp without time zone
);


--
-- Name: audits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audits_id_seq OWNED BY audits.id;


--
-- Name: contexts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contexts (
    id integer NOT NULL,
    title character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: contexts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contexts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contexts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contexts_id_seq OWNED BY contexts.id;


--
-- Name: descriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE descriptions (
    id integer NOT NULL,
    locale character varying DEFAULT 'en'::character varying,
    text text,
    status_id integer NOT NULL,
    image_id integer NOT NULL,
    metum_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    license character varying DEFAULT 'cc0-1.0'::character varying
);


--
-- Name: descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE descriptions_id_seq OWNED BY descriptions.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE images (
    id integer NOT NULL,
    path character varying,
    website_id integer NOT NULL,
    context_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    canonical_id character varying,
    assignments_count integer DEFAULT 0 NOT NULL,
    descriptions_count integer DEFAULT 0 NOT NULL,
    title text,
    priority boolean DEFAULT false NOT NULL,
    status_code integer DEFAULT 0 NOT NULL,
    page_urls text
);


--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: meta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE meta (
    id integer NOT NULL,
    title character varying,
    instructions text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meta_id_seq OWNED BY meta.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE statuses (
    id integer NOT NULL,
    title character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE statuses_id_seq OWNED BY statuses.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer NOT NULL,
    taggable_id integer NOT NULL,
    taggable_type character varying NOT NULL,
    tagger_id integer NOT NULL,
    tagger_type character varying NOT NULL,
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying NOT NULL,
    taggings_count integer DEFAULT 0 NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying,
    last_name character varying,
    authentication_token character varying,
    role user_role DEFAULT 'viewer'::user_role NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: websites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE websites (
    id integer NOT NULL,
    title character varying,
    url character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    strategy character varying
);


--
-- Name: websites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE websites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: websites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE websites_id_seq OWNED BY websites.id;


--
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignments ALTER COLUMN id SET DEFAULT nextval('assignments_id_seq'::regclass);


--
-- Name: audits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audits ALTER COLUMN id SET DEFAULT nextval('audits_id_seq'::regclass);


--
-- Name: contexts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contexts ALTER COLUMN id SET DEFAULT nextval('contexts_id_seq'::regclass);


--
-- Name: descriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions ALTER COLUMN id SET DEFAULT nextval('descriptions_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: meta id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta ALTER COLUMN id SET DEFAULT nextval('meta_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY statuses ALTER COLUMN id SET DEFAULT nextval('statuses_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: websites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY websites ALTER COLUMN id SET DEFAULT nextval('websites_id_seq'::regclass);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: contexts contexts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contexts
    ADD CONSTRAINT contexts_pkey PRIMARY KEY (id);


--
-- Name: descriptions descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT descriptions_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: meta meta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta
    ADD CONSTRAINT meta_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: websites websites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (id);


--
-- Name: associated_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX associated_index ON audits USING btree (associated_id, associated_type);


--
-- Name: auditable_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auditable_index ON audits USING btree (auditable_id, auditable_type);


--
-- Name: index_assignments_on_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignments_on_image_id ON assignments USING btree (image_id);


--
-- Name: index_assignments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignments_on_user_id ON assignments USING btree (user_id);


--
-- Name: index_audits_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_audits_on_created_at ON audits USING btree (created_at);


--
-- Name: index_audits_on_request_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_audits_on_request_uuid ON audits USING btree (request_uuid);


--
-- Name: index_descriptions_on_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_image_id ON descriptions USING btree (image_id);


--
-- Name: index_descriptions_on_metum_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_metum_id ON descriptions USING btree (metum_id);


--
-- Name: index_descriptions_on_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_status_id ON descriptions USING btree (status_id);


--
-- Name: index_descriptions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_user_id ON descriptions USING btree (user_id);


--
-- Name: index_images_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_images_on_context_id ON images USING btree (context_id);


--
-- Name: index_images_on_website_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_images_on_website_id ON images USING btree (website_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_role ON users USING btree (role);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taggings_idx ON taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_index ON audits USING btree (user_id, user_type);


--
-- Name: descriptions fk_rails_1baaf0e406; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_1baaf0e406 FOREIGN KEY (metum_id) REFERENCES meta(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: images fk_rails_3245e98929; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_3245e98929 FOREIGN KEY (website_id) REFERENCES websites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: descriptions fk_rails_58ab0d4634; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_58ab0d4634 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: assignments fk_rails_79515876ef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT fk_rails_79515876ef FOREIGN KEY (image_id) REFERENCES images(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: descriptions fk_rails_9f01492e23; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_9f01492e23 FOREIGN KEY (status_id) REFERENCES statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: images fk_rails_a71674751c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_a71674751c FOREIGN KEY (context_id) REFERENCES contexts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: assignments fk_rails_aa6b76dac2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT fk_rails_aa6b76dac2 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: descriptions fk_rails_d1b03e17ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_d1b03e17ed FOREIGN KEY (image_id) REFERENCES images(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20150625124853');

INSERT INTO schema_migrations (version) VALUES ('20150625125138');

INSERT INTO schema_migrations (version) VALUES ('20150625125139');

INSERT INTO schema_migrations (version) VALUES ('20150625125140');

INSERT INTO schema_migrations (version) VALUES ('20150625125141');

INSERT INTO schema_migrations (version) VALUES ('20150625125142');

INSERT INTO schema_migrations (version) VALUES ('20150625134302');

INSERT INTO schema_migrations (version) VALUES ('20150625142217');

INSERT INTO schema_migrations (version) VALUES ('20150625155015');

INSERT INTO schema_migrations (version) VALUES ('20150625155025');

INSERT INTO schema_migrations (version) VALUES ('20150625155026');

INSERT INTO schema_migrations (version) VALUES ('20150625155032');

INSERT INTO schema_migrations (version) VALUES ('20150701220841');

INSERT INTO schema_migrations (version) VALUES ('20150702152708');

INSERT INTO schema_migrations (version) VALUES ('20150708151043');

INSERT INTO schema_migrations (version) VALUES ('20150708191222');

INSERT INTO schema_migrations (version) VALUES ('20150724203747');

INSERT INTO schema_migrations (version) VALUES ('20150724215850');

INSERT INTO schema_migrations (version) VALUES ('20150724215851');

INSERT INTO schema_migrations (version) VALUES ('20150831153035');

INSERT INTO schema_migrations (version) VALUES ('20150903170221');

INSERT INTO schema_migrations (version) VALUES ('20160426130133');

INSERT INTO schema_migrations (version) VALUES ('20160525155525');

INSERT INTO schema_migrations (version) VALUES ('20160620125547');

INSERT INTO schema_migrations (version) VALUES ('20160621193039');

INSERT INTO schema_migrations (version) VALUES ('20160621220610');

INSERT INTO schema_migrations (version) VALUES ('20160727192933');

INSERT INTO schema_migrations (version) VALUES ('20160811173510');

INSERT INTO schema_migrations (version) VALUES ('20170320174821');

INSERT INTO schema_migrations (version) VALUES ('20170724200105');

INSERT INTO schema_migrations (version) VALUES ('20170724203045');

INSERT INTO schema_migrations (version) VALUES ('20170727161448');

INSERT INTO schema_migrations (version) VALUES ('20170727163758');

INSERT INTO schema_migrations (version) VALUES ('20170727190212');

INSERT INTO schema_migrations (version) VALUES ('20170727192426');

INSERT INTO schema_migrations (version) VALUES ('20170728134702');

