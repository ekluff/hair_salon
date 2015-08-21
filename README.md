# Hair Salon Empire

##### This is a web application that manages two classes of objects using ruby, postgres, and psql. It was created on August 21, 2015.

#### By Evan Clough

## Description

The application consists of two class files: client.rb and stylist.rb; four spec files: client_spec, integration_spec, stylist_spec, and spec_helper; six view pages: client.erb (displays detail of a single client and the name of their stylist), clients.erb (displays a list of all clients and their stylists), index.erb (displays two links to stylists.erb and clients.erb), layout.erb (header and footer information), stylist.erb (displays detail of a single stylist), and stylists.erb (displays a list of all stylist names).

It is driven by a database named hair_salon, and tested with a database named hair_salon_test (created on a template of the former). Hair_salon contains the following tables and fields: stylists (id serial PRIMARY KEY, name varchar), and clients (id serial PRIMARY KEY, stylist_id int, name varchar).

The flow of the stylist path is as follows. User:

vists index.erb, clicks "stylists"
is directed to stylists.erb, where may add a new stylist, delete existing stylists, or click a button to return to index.erb. Upon:
  -deleting stylist, directed to stylists.erb (if refreshes a delete request after deleting all stylists, delete method is not executed)
  -adding stylist, directed to stylists.erb
  -clicking stylist name, directed to stylist.erb, where may add new client to that stylist, change stylist name, or delete stylist. Upon
    -adding client, directed to stylist.erb
    -deleting client, directed to clients.erb (given additional dev time would direct to stylist.erb)
    -changing stylist name, directed to stylist.erb
    -deleting stylist, directed to stylists.erb
visits index.erb, clicks "clients"
is directed to clients.erb, where may add new clients, delete existing clients, click name of client to view client details, click name of stylist to view stylist details, or click button to return home (new clients may only be added if a stylist exists to be assigned to them). Upon:
  -adding client, is directed to clients.erb
  -deleting client, is directed to clients.erb
  -clicking client name, is directed to client.erb, where may change client name or stylist, delete client, or click button to go to clients or stylists views.
  -clicking stylist name, is directed to stylist.erb.

To execute the application, one must download it off github at https://github.com/ekluff/hair_salon.git, install postgres, psql, sinatra, capybara, and rspec gems on their computer, set up a database with the above names and tables, open terminal, navigate to the downloaded project folder, execute the command $ ruby app.rb, and navigate to http://localhost:4567/.

## Technologies Used

This application is written in ruby and run using sinatra. It is styled using bootstrap and custom css.

### Legal

Copyright (c) 2015 Evan Clough

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
