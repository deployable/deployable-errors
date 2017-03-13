
//const { RethrownError } = require('@deployable/errors')
const { RethrownError } = require('../')

function parseJson(str){
  try {
    JSON.parse(str)
  } catch (e) {
    throw new RethrownError(`JSON parse failed with: ${e.message}`, e)
  }
}

function go() {
  try {
    parseJson('kwyjibo')
  } catch (e) {
    console.log('The new Error:', e)
    throw e 
  }
}

go()

