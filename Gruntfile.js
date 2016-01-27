/*global module:false*/
module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-html-convert');

  var userConfig = require( './build.config.js' );

  // Project configuration.
  // grunt.initConfig({
  var taskConfig = {
    // Metadata.
    pkg: grunt.file.readJSON("package.json"),
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',
    // Task configuration.

    clean: [ 
      '<%= build_dir %>', 
      '<%= compile_dir %>'
    ],
    concat: {
      build_css: {
        src: [
          '<%= build_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css'
        ],
        dest: '<%= compile_dir %>/<%= pkg.name %>.css'
      },
      compile_js: {
        options: {
          banner: '<%= banner %>'
        },
        src: [ 
          '<%= vendor_files.js %>', 
          'module.prefix', 
          '<%= build_dir %>/src/**/*.js', 
          'module.suffix' 
        ],
        dest: '<%= compile_dir %>/<%= pkg.name %>.min.js'
      }
    },
    copy: {
      build_app_assets: {
        files: [
          { 
            src: [ '**' ],
            dest: '<%= build_dir %>/assets/',
            cwd: 'src/assets',
            expand: true
          }
       ]   
      },
      build_appjs: {
        files: [
          {
            src: [ '<%= app_files.js %>' ],
            dest: '<%= build_dir %>/',
            cwd: '.',
            expand: true
          }
        ]
      }
    },
    /**
     * `grunt coffee` compiles the CoffeeScript sources. To work well with the
     * rest of the build, we have a separate compilation task for sources and
     * specs so they can go to different places. For example, we need the
     * sources to live with the rest of the copied JavaScript so we can include
     * it in the final build, but we don't want to include our specs there.
     */
    coffee: {
      source: {
        options: {
          bare: true
        },
        expand: true,
        cwd: '.',
        src: [ '<%= app_files.coffee %>' ],
        dest: '<%= build_dir %>',
        ext: '.js'
      }
    },
    /**
     * `coffeelint` does the same as `jshint`, but for CoffeeScript.
     * CoffeeScript is not the default in ngBoilerplate, so we're just using
     * the defaults here.
     */
    coffeelint: {
      src: {
        files: {
          src: [ '<%= app_files.coffee %>' ]
        }
      },
      options: {
        max_line_length: {
          level: 'ignore'
        }
      }
    },

    /**
     * The `index` task compiles the `index.html` file as a Grunt template. CSS
     * and JS files co-exist here but they get split apart later.
     */
    index: {

      /**
       * During development, we don't want to have wait for compilation,
       * concatenation, minification, etc. So to avoid these steps, we simply
       * add all script files directly to the `<head>` of `index.html`. The
       * `src` property contains the list of included files.
       */
      build: {
        dir: '<%= build_dir %>',
        src: [
          '<%= vendor_files.js %>',
          '<%= build_dir %>/src/**/*.js',
          '<%= html2js.common.dest %>',
          '<%= html2js.app.dest %>',
          '<%= vendor_files.css %>',
          '<%= build_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css'
        ]
      }
    },

    htmlConvert: {
      options: {
        // custom options, see below     
      },
      mytemplate: {
        src: ['src/**/*.tpl.html'],
        dest: '<%= build_dir %>/src/templates.js'
      },
    },
    uglify: {
      compile: {
        options: {
          banner: '<%= banner %>'
        },
        files: {
          '<%= concat.compile_js.dest %>': '<%= concat.compile_js.dest %>'
        }
      }
    },
    less: {
      build: {
        files: {
          '<%= build_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css': '<%= app_files.less %>'
        }
      },
      compile: {
        files: {
          '<%= build_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css': '<%= app_files.less %>'
        },
        options: {
          cleancss: true,
          compress: true
        }
      }
    },
    jshint: {
      options: {
        curly: true,
        immed: true,
        newcap: true,
        noarg: true,
        sub: true,
        boss: true,
        eqnull: true
      },
      globals: {},
      gruntfile: {
        src: 'Gruntfile.js'
      }
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      }
    }
  };

  grunt.initConfig( grunt.util._.extend( taskConfig, userConfig ) );

  // Default task.
  grunt.registerTask('default', ['clean', 'htmlConvert', 'jshint', 'coffeelint', 'coffee', 'less:build', 'concat:build_css', 'copy:build_app_assets',
    'copy:build_appjs', 'concat:compile_js', 'uglify']);

};