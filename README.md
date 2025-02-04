Agreelist
=============
[![Code Climate](https://codeclimate.com/github/hectorperez/agreelist/badges/gpa.svg)](https://codeclimate.com/github/hectorperez/agreelist)
[![Build Status](https://travis-ci.org/agreelist/agreelist.svg?branch=master)](https://travis-ci.org/agreelist/agreelist)

Agreelist is a non-profit aiming to fight misinformation and improve the quality of debates by showing what people think and why, on both sides of key issues.

https://agreelist.org - Tracking influencers' opinions

Example of topic:
-------
![topic example](https://s3-eu-west-1.amazonaws.com/agreelist/basic+income+for+github.png)


API
-------
GraphQL API https://agreelist.org/api/v1

Example of use:
https://agreelist.org/api/v1?query={agreements(after:8000,limit:3){id,reason,extent,individual{name,twitter,wikipedia},statement{content}}}

```
{
  agreements(after: 8800, limit: 3) {
    id
    reason
    extent
    individual {
      name
    }
    statement {
      content
    }
  }
}
```
1. agreements (limit: Int = 10, after: Int = 1) - Votes from individuals on statements
- id: Integer
- individual: Individual
- statement: Statement
- extent: Int (agree: 100, disagree: 0)
- reason: String
- url: String

2. individuals (limit: Int = 10, after: Int = 1) - Person or organization who agrees or disagrees statements
- id: Integer
- name: String
- twitter: String
- wikidata_id: String
- wikipedia: String

3. statements (limit: Int = 10, after: Int = 1) - Topic or statement which can be agreed or disagreed
- id: Integer
- content: String (title or content of the statement)

Prerequisites:
-------
```bash
# Redis
sudo dnf install redis # Fedora
sudo apt-get install redis-server # Ubuntu
brew install redis # Mac

# PostgreSQL
sudo dnf install postgresql postgresql-server postgresql-devel # Fedora
sudo apt-get install postgresql postgresql-contrib libpq-dev # Ubuntu
```

Install:
-------
```ruby
git clone git://github.com/hectorperez/agreelist.git
cd agreelist
bundle install
cp config/database.yml.example config/database.yml
rake db:create
rake db:setup
```

Start local server:
```
redis-server
bundle exec sidekiq
rails s
```

Contribute:
--------
1. Find or create an issue

2. Add a comment to the issue to let people know you're going to work on it

3. Fork

4. Hack your changes in a topic branch (don't forget to write some tests ;)

5. Make pull request

6. Wait for comments from maintainers or code merge

Get in touch
-------
- Twitter: [@arpahector](https://twitter.com/arpahector)
- Email: hector@agreelist.org
- Chat: [Slack](https://join.slack.com/t/agreelist/shared_invite/enQtMzQ3NjQ5NTY1MDI0LTg2ZmVmZWI2MzFlNDNjM2M2NDA5MjM4ZTA5NDYxYmVhMzAyNGZlNjE4ZWNhMDYxOWIyODM3NGE5YjM1MjlhNTU)

License:
-------
AGPLv3
