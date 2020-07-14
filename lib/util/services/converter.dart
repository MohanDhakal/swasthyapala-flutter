String getRealUri(placeHolderUri) {
  return placeHolderUri
      .split('\/')
      .join('/')
      .replaceAll('/home/swasthya/public_html', 'http://swasthyapala.com');
}
