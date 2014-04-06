$(function() {

    //Create a model for Profilesd(
    var Profile = Backbone.Model.extend({

        defaults:{
            name: 'someone',
            description: 'something',
            checked: false
        },

        //helper function for checking/unchecking a profile
        toggle: function(){
            this.set('checked', !this.get('checked'));
        },

        setTrue: function(){
            this.set('checked', true);
        },

    });

    //Create a collection of profiles
    var ProfileList = Backbone.Collection.extend({
        model: Profile,

        getChecked: function(){
            return this.where({checked:true});
        },

    });

    //Prefill the collection with a number of profiles.
    var profiles = new ProfileList([
        new Profile({name: 'shivsnagini', description: 'student|mobile fanatic|entrepreneur',checked: false}),
        new Profile({name: 'brandon57', description: 'student|frat star|javascipter',checked: false}),
        new Profile({name: 'angie92', description: 'student|hipster coder|startup chick',checked: false})
    ]);

    //This view turns a Service model into HTML. Will create LI elements.
    var ProfileView = Backbone.View.extend({
        tagName: 'li',
        
        events: {
            'click': 'toggleService',
        },

        initialize: function(){
            //Set up event listeners
            this.listenTo(this.model, 'change', this.render);
        },
        

        render: function(){
            //create the HTML
         this.$el.html('<input type="checkbox" value="1" name="' + this.model.get('name') + '" /> ' + this.model.get('name') + "&nbsp&nbsp&nbsp&nbsp" +'<span>' + this.model.get('description') + '</span>');
            this.$('input').prop('checked', this.model.get('checked'));
        
        return this;
        },

        toggleService: function(){
            this.model.toggle();
        }
    });

    //the main view of the app
    var App = Backbone.View.extend({
        el: $('#main'),

        events: {
            'click #addall': 'selectAllProfiles'
        },

        initialize: function(){
            //set up backbone
            this.total = $('#total span');
            this.list  = $('#profiles');

        // Listen for the change event on the collection.
            // This is equivalent to listening on every one of the 
            // service objects in the collection.
            this.listenTo(profiles,'change',this.render);

            //Create views for every one of the profiles in 
            //the collection and add them to the page

            profiles.each(function(profile){
                var view = new ProfileView({ model: profile });
                this.list.append(view.render().el);

            }, this); //this is the context in the callback
        },

        render: function(){
            // Calculate the total order amount by agregating
            // the prices of only the checked elements

            var total = 0;

            _.each(profiles.getChecked(), function(elem){
                total += 1
            });

            // Update the total 
            this.total.text(total);

            return this;
        },
        selectAllProfiles: function(){
            profiles.each(function(profile){
                profile.setTrue();
            });
        },

    });
    new App();
});