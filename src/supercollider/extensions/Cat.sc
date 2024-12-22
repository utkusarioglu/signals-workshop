Cat {
  var <dog;

  *new { | doggo |
    ^super.newCopyArgs(doggo);
  }

  woof {
    ^this.dog;
  }
}
