class Game {
  String _barcode;
  String _name;
  int _numberOfPlays;
  int _tokensGiven;

  Game(this._barcode, this._name,
      [this._numberOfPlays = 0, this._tokensGiven = 0]);

  String getBarcode() {
    return _barcode;
  }

  void setBarcode(String newBarCode) {
    _barcode = newBarCode;
  }

  String getName() {
    return _name;
  }

  void setName(String newName) {
    _name = newName;
  }

  int getNumPlays() {
    return _numberOfPlays;
  }

  void setNumPlays(int numPlays) {
    _numberOfPlays = numPlays;
  }

  int getTokensGiven() {
    return _tokensGiven;
  }

  void setTokensGiven(int tokensGiven) {
    _tokensGiven = tokensGiven;
  }

  @override
  String toString() {
    return "_barcode: " + _barcode + " | name: " + _name;
  }
}
