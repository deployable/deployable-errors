# @deployable/errors

Standard set of custom Error classes including a base class `ExtendedError` to create any new Error classes from. 

## Usage

    npm install --save @deployable/errors
   
    yarn add @deployable/errors

Then require

```javascript 

const {ValidationError, KeyError, HttpError, ExtendedError} = require('@deployable/errors')

```

## `ExtendedError`

Base class used to extend errors


``` javascript

const {ExtendedError} = require('deployable-errors')

class MyError extends ExtendedError {}

let err = new MyError('Here\'s a new error!')

```


#### `.simple`

Place to store a human readable error message.

``` javascript

let err = new MyError('foo missing bar variable.', { simple: "There was problem with foo" })
   
console.log(err.simple)

```

## `ValidationError`

An error to throw when something simple goes wrong to be handled with output to the user. 

``` javascript

const {ValidationError} = require('deployable-errors')

let err = new ValidationError('Store should not be a number', { field: 'store', value: 9 })

```

The error holds the `.value` and `.field` properties for later inspection.

#### `.field`

Validation field

#### `.value`

Validation value


## `HttpError`

HttpError includes a helper function that will lookup a HTTP spec table of errors.
It can include a standard error message if none is provided.

``` javascript

const {HttpError} = require('deployable-errors')

let err = HttpError.create(403,'You are not allowed to access /admin')

```

A HttpError stores the `.status` for later use, like in an Express error route.

#### `.status`

Stores the HTTP Status code.
 
## `KeyError`

Something generic to throw when a property is missing (Rubyish)

``` javascript

const {KeyError} = require('deployable-errors')
  
let store = { one: 1, two: 2 }
ley key = 'three'
let number = store[three]
if (!number) throw new KeyError('Number not found', { key: key })
return number

```

#### `.key`

The key that failed

