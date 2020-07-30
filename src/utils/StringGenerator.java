package utils;

import java.util.Random;

public class StringGenerator {

    private static Random random = new Random();
    public static final char[] DIGITS_SET = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    public static final char[] LETTERS_SET = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                                        'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D',
                                        'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
                                        'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
    public static final char[] SPECIAL_CHARACTERS_SET = {'`', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-',
                                                    '=', '_', '+', '[', ']', '{', '}', '|', '\\', '/', '?', ';', ':'};

    public static final char[] DIGITS_AND_LETTERS_SET = concat(DIGITS_SET, LETTERS_SET);

    public static final char[] DIGITS_AND_SPECIAL_CHARACTERS_SET = concat(DIGITS_SET, SPECIAL_CHARACTERS_SET);

    public static final char[] LETTERS_AND_SPECIAL_CHARACTERS_SET = concat(LETTERS_SET, SPECIAL_CHARACTERS_SET);

    public static final char[] ALL_SET = concat(DIGITS_SET, LETTERS_SET, SPECIAL_CHARACTERS_SET);

    protected static char[] concat(char[]...chars){
        int totalLength = 0;
        int currIndex= 0;
        for(int i = 0; i < chars.length; i++){
            totalLength += chars[i].length;
        }
        char[] result = new char[totalLength];
        for(int i = 0; i < chars.length; i++){
            for(int j = 0; j < chars[i].length; j++){
                result[currIndex++] = chars[i][j];
            }
        }
        return result;
    }

    public static String getRandomString(){
        return getRandomString(6, 12, DIGITS_AND_LETTERS_SET);
    }

    public static String getRandomString(int minLength, int maxLength){
        return getRandomString(minLength, maxLength, DIGITS_AND_LETTERS_SET);
    }

    public static String getRandomString(int minLength, int maxLength, char[] charSet){
        // invalid request
        if((minLength < 1) || (maxLength < minLength) || (charSet == null) || (charSet.length == 0)){
            return null;
        }
        int setLength = charSet.length;
        StringBuilder tempString = new StringBuilder();
        int stringLength = random.nextInt( (maxLength - minLength + 1)) + minLength;
        for(int i = 0; i < stringLength; i++){
            tempString.append(charSet[random.nextInt( setLength)]);
        }
        return tempString.toString();
    }
}
