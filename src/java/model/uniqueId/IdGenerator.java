package model.uniqueId;

public class IdGenerator {
    enum Charset {
        ALPHANUMERIC("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),
        ALPHABET("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"),
        UPPER("ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
        LOWER("abcdefghijklmnopqrstuvwxyz"),
        DIGITS("0123456789");
        private final String charSet;
        Charset(String charSet){this.charSet = charSet;}
        @Override
        public String toString(){return this.charSet;}
    }
    
    /**
     * Creates string of given length and Charset
     * @param length
     * @param chars
     * @return
     */
    public String create(int length, Enum<Charset> chars){
        StringBuilder builder = new StringBuilder();
        String ref = chars.toString();
        for (int i = 0; i < length; i++) {
            builder.append(ref.charAt(new java.util.Random().nextInt(ref.length())));
        }        
        return builder.toString();
    }   
    /**
     * Creates an ID string using the given string format
     * Ex: ??XX-AAaa-0000
     * Alphanumeric(?)
     * Alphabet(X)
     * Uppercase(A)
     * Lowercase(a)
     * Digits(0)
     * Dash(-)
     * @param format
     * @return formattedId
     */
    public String createFormatted(String format){
        StringBuilder builder = new StringBuilder();
        String ref;
        for (char c: format.toCharArray()){
            switch (c) {
                case '?':
                    ref = Charset.ALPHANUMERIC.toString();
                    break;
                case 'X':
                    ref = Charset.ALPHABET.toString();
                    break;
                case 'A':
                    ref = Charset.UPPER.toString();
                    break;
                case 'a':
                    ref = Charset.LOWER.toString();
                    break;
                case '0':
                    ref = Charset.DIGITS.toString();
                    break;
                case '-':
                    ref = "-";
                    break;                        
                default:
                    throw new AssertionError();
            }
            builder.append(ref.charAt(new java.util.Random().nextInt(ref.length())));
        }       
        return builder.toString();
    }
}
