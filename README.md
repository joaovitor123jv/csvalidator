[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


# CSValidator


### Validate your CSV files easily through this lib

-----------
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Available validation methods](#available-validation-methods)
  * [Prerequisites](#prerequisites)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)
* [Report Bug](https://github.com/joaovitor123jv/csvalidator/issues)
* [Request Feature](https://github.com/joaovitor123jv/csvalidator/issues)



## About The Project

An open source CSV validation library written fully in ruby
to help make CSV imports in rails or sinatra server more
secure and accurate


### Built With

* [Ruby](https://www.ruby-lang.org/en/about/)



<!-- GETTING STARTED -->
## Getting Started

* Clone the project locally
    ```bash
    git clone https://github.com/joaovitor123jv/csvalidator
    ```

* Call it from somewhere (in this case, from a ruby file)
    ```ruby
    #!/usr/bin
    # Optional file name "csvalidator_caller.rb"

    require 'csvalidator'

    validator = CSValidator.new("path/to/file.csv", {
        "Column Bertioga": [ # Order doesn`t matter, is the column name
            :is_not_empty,
            :is_integer,
            :is_positive
        ],
        "Column Ubatuba": [
            :is_not_empty,
            :is_comma_float,
            :is_positive
        ],
        "Column São Paulo": [
            :is_not_empty
        ],
        "Parelelepipedo": [
            :is_not_empty,
            {is_date_on_format: '%m/%Y'},
            {is_on_month: 9},
            {is_on_year: "2020"}
        ],
        "Brazil State": [
            :is_not_empty,
            {is_one_of: [
                'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES',
                'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR',
                'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC',
                'SP', 'SE', 'TO', 'EX', '-1'
            ]}
        ],
        "Binary Value": [
            {has_max_length: 2},
            {has_min_length: 2},
            {has_length: 2},
        ]
    })

    # Shows first lines of the CSV
    validator.csv_content_preview

    # Show validation rules
    validator.rules_overview

    # Run validations
    validator.validate

    # Know how many errors and/or warning(WIP) you got
    validator.overview([ :all_errors ])
    ```

* Run it!
    ```sh
    ruby csvalidator_caller.rb
    ```

* Enjoy!

### Available validation methods

* is_integer:
    - No params
    - Converts field validated to integer (always decimal), if possible
    - Possible input: `"00239"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_integer
        ]
        ```

* is_float
    - No params
    - Converts field validated to float, if possible
    - Possible input: `"00239.92"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_float
        ]
        ```

* is_comma_float
    - No params
    - Converts field validated to float, if possible
    - Possible input: `"00239,92"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_comma_float
        ]
        ```

* is_comma_float_with_thousands_separator
    - No params
    - Converts field validated to float, if possible
    - Possible input: `"1.002.239,92"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_comma_float_with_thousands_separator
        ]
        ```

* is_positive
    - No params
    - Field must be numeric
    - Possible input: `19283`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_integer,
            :is_positive
        ]
        ```

* is_upcase
    - No params
    - Possible input: `"ALABAMA"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_upcase
        ]
        ```

* is_not_empty
    - No params
    - `nil` and `""` are considered as "empty"
    - Possible input: `"anything"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_not_empty
        ]
        ```

* is_not_zero
    - No params
    - Possible input: `0`
    - Possible usage: 
        ```ruby
        "Column Key": [
            :is_not_zero
        ]
        ```

* is_date_on_format
    - Converts validated field to Date, if possible
    - Param: Date format
    - Possible param: `"%Y/%m"`
    - Possible input: `"2020/09"`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {is_date_on_format: '%Y/%m'}
        ]
        ```

* is_on_month
    - Must be `Date` or `Time`
    - Param: Month number (January is 1)
    - Possible param: `#<Date: 2020-01-01 ((2458850j,0s,0n),+0s,2299161j)>`
    - Possible input: `1`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {is_date_on_format: '%Y/%m'},
            {is_on_month: 1}
        ]
        ```

* is_on_year
    - Must be `Date` or `Time`
    - Param: Year number
    - Possible param: `#<Date: 2020-01-01 ((2458850j,0s,0n),+0s,2299161j)>`
    - Possible input: `2020`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {is_date_on_format: '%Y/%m'},
            {is_on_year: 2020}
        ]
        ```

* is_one_of
    - Param: Possible values to field
    - Possible param: `[1, 3, 6, 8, 10]`
    - Possible input: `3`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {is_one_of: [
                1, 3, 6, 8, 10
            ]}
        ]
        ```

* has_max_length
    - Param: Maximum length
    - Possible param: `10`
    - Possible input: `'asdqwerc'`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {has_max_length: 10}
        ]
        ```

* has_min_length
    - Param: Minimum length
    - Possible param: `10`
    - Possible input: `'asdqwertfalkfjkpgoc'`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {has_min_length: 10}
        ]
        ```

* has_length
    - Param: Required length
    - Possible param: `10`
    - Possible input: `'flaoekqmnv'`
    - Possible usage: 
        ```ruby
        "Column Key": [
            {has_length: 10}
        ]
        ```


### Prerequisites


* ruby 2.3.1 or newer
```sh
# If using debian-based distro
sudo apt install ruby

# If using arch-based distro
sudo pacman -S ruby

# If using suse-based distro
sudo zypper in ruby

# Already installed on macs
```


## Roadmap

See the [open issues](https://github.com/joaovitor123jv/csvalidator/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## License

Distributed under the MIT License. See `LICENSE` for more information.


## Contact

João Vitor - [linkedin](https://www.linkedin.com/in/jo%C3%A3o-vitor-antoniassi-segantin-844237109/) - segantin.jv@gmail.com

Project Link: [https://github.com/joaovitor123jv/csvalidator](https://github.com/joaovitor123jv/csvalidator)



## Acknowledgements
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [Animate.css](https://daneden.github.io/animate.css)
* [Loaders.css](https://connoratherton.com/loaders)
* [Slick Carousel](https://kenwheeler.github.io/slick)
* [Smooth Scroll](https://github.com/cferdinandi/smooth-scroll)
* [Sticky Kit](http://leafo.net/sticky-kit)
* [JVectorMap](http://jvectormap.com)
* [Font Awesome](https://fontawesome.com)




[contributors-url]: https://github.com/joaovitor123jv/csvalidator/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/joaovitor123jv/csvalidator.svg?style=flat-square
[forks-url]: https://github.com/joaovitor123jv/csvalidator/network/members
[stars-shield]: https://img.shields.io/github/stars/joaovitor123jv/csvalidator.svg?style=flat-square
[stars-url]: https://github.com/joaovitor123jv/csvalidator/stargazers
[issues-shield]: https://img.shields.io/github/issues/joaovitor123jv/csvalidator.svg?style=flat-square
[issues-url]: https://github.com/joaovitor123jv/csvalidator/issues
[license-shield]: https://img.shields.io/github/license/joaovitor123jv/csvalidator.svg?style=flat-square
[license-url]: https://github.com/joaovitor123jv/csvalidator/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jo%C3%A3o-vitor-antoniassi-segantin-844237109/