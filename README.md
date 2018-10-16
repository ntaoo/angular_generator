# Angular Generator

AngularDart file generators.

## Install

### From GitHub

    pub global activate --source git <repo>

### From Local

    pub global activate --source path <path>
    
## Status

Under development. Will frequently make breaking changes without notice.

    ngg component <path>
    ngg router <path> (* Not implementetd *)
    ngg pipe <path> (* Not implementetd *) (* low priority *)

## Example

    ngg component ui/components/user

## Component Generator Plan

Would support three styles.

    ngg component <path> --naming=<default, neutral, common> 

```
// default
user/
  user.dart
  user.scss
  user.html

// neutral
user/
  user_component.dart
  user_component.scss
  user_component.html

// common
user_component/
  user_component.dart
  user_component.scss
  user_component.html    
```

TODO: Stateless Component (OnPush) option?

## TODO

* Use source_gen.
* Router Generator.
* Pipe Generator.