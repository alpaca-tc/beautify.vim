# Beautify.vim

- This little **beautifier** will reformat and reindent.
- This **converter** will convert text selected to other syntax.

![DEMO]( assets/01.gif )
![DEMO]( assets/02.gif )

## Usage

**Beautify.vim** is reformatter and converter.

### Reformatting

This plug-in support js, json, css and html as reformatter. In the case of the buffer already set filetype, reformatter is selected automatically. Therefore, if you want result then, you have only to execute `:Beautify`.

- `html-beautify`
- `css-beautify`
- `js-beautify`
- `jq`

### Converting

This plug-in support converting buffer to other syntax. If you want to convert buffer to haml from html, executing `:Beautify html2haml`.

- `html2haml`
- `erb2haml`
- `css2haml`
- `js2coffee`
- `css2scss`
- `css2sass`
- `scss2sass`
- `sass2scss`

## How to install

*NeoBundle*

```
NeoBundleLazy 'alpaca-tc/beautify.vim', {
      \ 'autoload' : {
      \   'commands' : [
      \     {
      \       'name' : 'Beautify',
      \       'complete' : 'customlist,beautify#complete_options'
      \     }
      \ ]
      \ }}
```

*Bundle*

```
Bundle 'alpaca-tc/beautify.vim'
```

**Install js-beautify**

`Beautify` depends on [npm](http://www.joyent.com/blog/installing-node-and-npm), jq, [js-beautify](https://npmjs.org/package/js-beautify) and [html2haml](https://github.com/haml/html2haml).
You need to install them.

- `npm install -g js-beautify`
- `npm install -g jq`
- `gem install html2haml --pre`
- `gem install sass`

**Check installing**

`:call beautify#debug#check_available()`

## Configuration

If you want to configure js-beautify settings, you can check out [here](https://github.com/einars/js-beautify)

**Vim configuration**

```
" let g:beautify#beautifier#npm_beautifier#bin = {
"        \ 'javascript' : 'js-beautify',
"        \ 'css'        : 'css-beautify',
"        \ 'html'       : 'html-beautify' }
" let g:beautify#beautifier#jq#bin = 'jq'
" let g:beautify#beautifier#html2haml#bin = 'html2haml'
" let g:beautify#beautifier#sass_convert#bin = 'sass-convert'

" How to open result
" 'vnew', 'tabnew' etc..
" let g:beautify#default_outputter = 'current_buffer'

" If you want to use new hash syntax of ruby19, you set 1 to the following variable.
" let g:beautify#beautifier#html2haml#ruby19_attributes = 0
```

## Commands

- `:Beautify [{beautifier-name}]`

## License

AUTHOR: alpaca-tc <alprhcp666@gmail.com>

Last Modified: 26 Oct 2013

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
