package model;

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
    public String create(int len, Enum<Charset> chars){
        StringBuilder builder = new StringBuilder();
        String ref = chars.toString();
        for (int i = 0; i < len; i++) {
            builder.append(ref.charAt(new java.util.Random().nextInt(ref.length())));
        }        
        return builder.toString();
    }   
}
