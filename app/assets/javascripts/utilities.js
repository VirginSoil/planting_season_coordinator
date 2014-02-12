function parseId(id) {
  return id.split("-").slice(1,3);
}

function arraysIdentical(a, b) {
  var i = a.length;
  if (i != b.length) return false;
  while (i--) {
      if (a[i] !== b[i]) return false;
  }
  return true;
}

function checkPlanted(squares) {
  if (squares.length === 0) {
    alert("Please select a square!");
    return true;
  }
  return false;
}