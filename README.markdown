# Easy Table

Table helpers for your views to facilitate creating tables using a nice DSL similar to what 'simpleform' and 'formtastic' are for forms ;)

## Install

<code>gem install easy-table</code>

## Demo

<pre> 
  <code>
  data_table @posts, %w{Id Title}, :summary => 'many posts', :caption => 'posts table'  

  =>
  <table>
    <thead>
      <tr>
        <th>id</th>
        <th>title</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>my post</td>
      </tr>
      <tr>
        <td>2</td>
        <td>my other post</td>
      </tr>
    </tbody>
  </table>  
  </code>
</pre>

## Helpers

The following is the current Table Helper API. 

_Note:_ This API clearly needs to be cleaned up in the "near" future ;)

### Table

* data_table
* table
* render_table

### Table parts

* render_tbody
* table_body
* render_caption
* render_header
* render_footer
* headers

### Rows

* row
* data_rows
* data_row

### Cells

* cells
* cell

### Misc

* indent_tag_

## Usage   

The following examples might not all be compatible with any API changes. 
Please raise an issue if you find a mismatch or have a problem using it ;)
Thanks!

Example: Using *table* helper

<pre>
  <% table @posts, %w{ID title} do |post, klass| -%>
      <tr class="<%= klass %>">
        <td><%= post.id</td>
        <td><%= post.title </td>
      </tr>
  <% end -%>  
</pre>

Example: Using *row* helper

<pre>
  <% table @posts, %w{ID title} do |post, klass| -%>
      <% row klass do |post| -%>
        <td><%= post.id %></td>
        <td><%= post.title %></td>
      <% end -%>
  <% end -%>  
</pre>

Example: Using *row* and *cell* helpers

<pre>
  <% table @posts, %w{ID title} do |post, klass| -%>
      <% row klass do |post| -%>
        <%= cell post.id %>
        <%= cell post.title %>
      <% end -%>
  <% end -%>  
</pre>

Example: Using *data_row* helper

<pre>
  <% table @posts, %w{ID title} do |post, klass| -%>
      <% data_row post, %w{id title}, klass -%>
  <% end -%>  
</pre>


Example: Using *cells* helper

The last argument to cells is the CSS classes to cycle

<pre>
  <% table @posts, %w{ID title} do |post, klass| -%>
      <% row klass do |post| -%>
        <%= cells post, %w{id title}, %w{number label} %>
      <% end -%>
  <% end -%>  
</pre>

Example: Using *rows* helper

<pre>
  <% render_table 'posts', 'Posts table', do -%>
      <% rows @posts, klass, :id, :title -%>
  <% end -%>  
</pre>


Example: Using *data_table* helper

This will by default try to extract attribute names from the headers list!
<pre>
  <% data_table @posts, %w{ID title}, :summary => 'Posts table' -%>
</pre>

Supply an :attributes options hash value to select attributes to display

<pre>
  <% data_table @posts, %w{Number Title}, :attributes => %w{id label} -%>
</pre>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
