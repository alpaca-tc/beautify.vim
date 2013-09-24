# README

## v0.2

*TODO*

- [ ] Write document.
- [x] Separate each of beautifier to sources.
- [ ] Import beautifier into repository.
- [ ] Append ruby-beautifer source

## Beautify

This little beautifier will reformat and reindent.

![DEMO](http://gifzo.net/MOoKNlUYIm.gif)

## Usage


*`:Beautify`*

Reformat current buffer automatically.

*`:JsBeautify`*
*`:CssBeautify`*
*`:HtmlBeautify`*

Reformat current buffer with js-beautify, css-beautify or html-beautify.

## Install

*NeoBundle*

```
NeoBundleLazy 'alpaca-tc/beautify.vim', { 
      \ 'build' : {
      \   'mac': 'npm install -g js-beautify',
      \ },
      \ 'autoload' : {
      \   'commands' : ['JsBeautify', 'Beautify', 'CssBeautify', 'HtmlBeautify']
      \ }}
```

*Bundle*

```
Bundle 'alpaca-tc/beautify.vim'
```

**Install js-beautify**

`Beautify` depends on [npm](http://www.joyent.com/blog/installing-node-and-npm) and js-beautify.
You have to install js-beautify.

`npm install -g js-beautify`

## Configuration

If you want to configure js-beautify settings, you can check out [here](https://github.com/einars/js-beautify)

**Vim variables**

```
" Default value
let g:beautify#bin = {
        \ 'javascript' : 'js-beautify',
        \ 'css'        : 'css-beautify',
        \ 'html'       : 'html-beautify' }
" 'vnew', 'tabnew' etc..
let g:beautify#outputter = 'current_buffer'
```

## License

AUTHOR: alpaca-tc <alprhcp666@gmail.com>
Last Modified: 2013-09-18

> License: MIT license
> Permission is hereby granted, free of charge, to any person obtaining
> a copy of this software and associated documentation files (the
> "Software"), to deal in the Software without restriction, including
> without limitation the rights to use, copy, modify, merge, publish,
> distribute, sublicense, and/or sell copies of the Software, and to
> permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
> 
> The above copyright notice and this permission notice shall be included
> in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
> IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
> CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
