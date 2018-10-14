class PagesController < ApplicationController
    def main
        @title = 'Main page';
        @content = 'This is the main page'
    end
end
