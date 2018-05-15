{-# LANGUAGE OverloadedStrings #-}

import           AWSLambda.Events.APIGateway
import           Control.Lens                hiding ((.=))
import           Data.Aeson
import           Data.ByteString.Lazy        (toStrict)
import           Data.Function
import           Data.Text                   (Text)
import           Data.Text.Encoding          (decodeUtf8)

data Response = Response
  { message :: String
  }

instance ToJSON Response where
  toJSON (Response message) = object ["message" .= message]

toJSONText :: ToJSON a => a -> Text
toJSONText value = decodeUtf8 $ toStrict $ encode value

main :: IO ()
main = apiGatewayMain hello

hello :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse Text)
hello request = do
  print request
  return $ responseOK & responseBody ?~ toJSONText response
  where
    response = Response {message = "Hello serverless haskell!"}
